package main

import (
	"fmt"
	"log"
	"net/url"
	"os"
	"database/sql"
	"github.com/go-martini/martini"
	"github.com/martini-contrib/render"
	"github.com/coopernurse/gorp"
	_ "github.com/go-sql-driver/mysql"
)

type House struct {
	Id int64 `db:"id"`
	Firstname string `db:"firstname"`
	Lastname string `db:"lastname"`
	City string `db:"city"`
	NumOfPeople string `db:"num_of_people"`
	HasChild string `db:"has_child"`
}

type Energy struct {
	Id int64 `db:"id"`
	Label int `db:"label"`
	House int64 `db:"house"`
	Year int `db:"year"`
	Month int `db:"month"`
	Temperature float32 `db:"temperature"`
	Daylight float32 `db:"daylight"`
	EnergyProduction int `db:"energy_production"`
}

func checkErr(err error, msg string) {
	if err != nil {
	    log.Fatalln(msg, err)
	}
}

func convertDatasource(ds string, params string) string {
	url, _ := url.Parse(ds)
	return fmt.Sprintf("%s@tcp(%s:3306)%s%s", url.User.String(), url.Host, url.Path, params)
}

var dbmap *gorp.DbMap

func initDb() *gorp.DbMap {
	var datasource string
	params := "?charset=utf8&parseTime=true&loc=Asia%2FTokyo"

	// for heroku with cleardb
	if os.Getenv("CLEARDB_DATABASE_URL") != "" {
		datasource = convertDatasource(os.Getenv("CLEARDB_DATABASE_URL"), params)
	} else {
		datasource = fmt.Sprintf("root:tech3!06@/energydatasimulationchallenge%s", params)
	}

	db, err := sql.Open("mysql", datasource)
	// db, err := sql.Open("mysql", "root:tech3!06@unix(/var/run/mysqld/mysqld.sock)/energydatasimulationchallenge")
	checkErr(err, "sql.Open failed")

	dbmap := &gorp.DbMap{Db: db, Dialect: gorp.MySQLDialect{"InnoDB", "UTF8"}}

	dbmap.AddTableWithName(House{}, "houses").SetKeys(true, "Id")
	err = dbmap.CreateTablesIfNotExists()
	checkErr(err, "Create tables failed")

	dbmap.AddTableWithName(Energy{}, "energies").SetKeys(true, "Id")
	err = dbmap.CreateTablesIfNotExists()
	checkErr(err, "Create tables failed")

	return dbmap
}

func main() {
	dbmap = initDb()
	defer dbmap.Db.Close()

	// err := dbmap.TruncateTables()
	//  checkErr(err, "TruncateTables failed")

	m := martini.Classic()
	m.Use(render.Renderer())

	m.Get("/api/houses/list", func(r render.Render) {
		selectStr := "select * from houses"

		// Start a new transaction
		trans, err := dbmap.Begin()
		checkErr(err, "Start new transaction failed")

		var houses []House
		_, err = trans.Select(&houses, selectStr)

		err = trans.Commit()

		r.JSON(200, houses)
	})

	m.Get("/api/houses/:houseId", func(args martini.Params, r render.Render) {
		selectStr := "select * from houses where id = ?"

		// Start a new transaction
		trans, err := dbmap.Begin()
		checkErr(err, "Start new transaction failed")

		var houses []House
		_, err = trans.Select(&houses, selectStr, args["houseId"])

		err = trans.Commit()

		r.JSON(200, houses)
	})

	m.Get("/api/energies/list", func(r render.Render) {
		selectStr := "select * from energies"

		// Start a new transaction
		trans, err := dbmap.Begin()
		checkErr(err, "Start new transaction failed")

		var energies []Energy
		_, err = trans.Select(&energies, selectStr)

		err = trans.Commit()

		r.JSON(200, energies)
	})

	m.Get("/api/energies/:houseId", func(args martini.Params, r render.Render) {
		selectStr := "select * from energies where house = ?"

		// Start a new transaction
		trans, err := dbmap.Begin()
		checkErr(err, "Start new transaction failed")

		var energies []Energy
		_, err = trans.Select(&energies, selectStr, args["houseId"])

		err = trans.Commit()

		r.JSON(200, energies)
	})

	m.Run()
}