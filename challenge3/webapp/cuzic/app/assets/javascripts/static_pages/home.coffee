$ ->
  jQpie = $('#pie')
  jQline = $('#line')
  do ->
    width = jQpie.parent().width()
    jQpie.width( width*0.9 )
    jQpie.height( width*0.9 )

    jQline.width( width*0.9 )
    jQline.height( width*0.9 )
    return

  do ->
    d3.csv("./energies/all.csv", ( (error, energies) ->
      ndx = crossfilter(energies)
      do ->
        pie = dc.pieChart("#pie")
        pieDimension  = ndx.dimension(
          (row) -> row["city"]
        )
        countGroup =
          pieDimension
          .group()
          .reduceSum( (row) ->
            row["energy_production"]
          )

        pie
          .width(jQpie.width())
          .height(jQpie.height())
          .slicesCap(4)
          .innerRadius(100)
          .dimension(pieDimension)
          .group(countGroup)
          .legend(dc.legend())
          .label( (d) -> "#{d.key || d.data.key} \n (#{d.value.toLocaleString()})" )

        pie.render()
        return

      do ->
        line = dc.lineChart("#line")
        monthDimension  = ndx.dimension(
          (row) -> row["month"]
        )
        sumGroup =
          monthDimension
          .group()
          .reduceSum( (row) ->
            row["energy_production"]
          )

        line = line.width(jQline.width())
        line = line.height(jQline.height())
        line = line.x(d3.scale.linear().domain([0,12]))
        # line = line.y(d3.scale.linear().domain([40000,90000]))
        line = line.renderArea(true)
        line = line.brushOn(false)
        # line = line.renderDataPoints(true)
        # line = line.clipPadding(-100)
        line = line.renderHorizontalGridLines(true)
        # line = line.yAxisLabel("Energy Production")
        line = line.elasticY(false)
        line = line.dimension(monthDimension)
        line = line.group(sumGroup)
        line = line.group(sumGroup)
        line.render()
        return
      )
    )

 # do ->
 #   jQpie.on("click",
 #   return
  return
