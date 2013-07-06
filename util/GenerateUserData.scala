
import scala.util._
import java.io.PrintWriter

/**
* generate user data with random number
*
* arg1: number of files
*/

val num = Try {args(0).toInt}.getOrElse(1)

println("generating " + num + " user data")

(1 to num).foreach{ index =>
    val file = "data/user/user_" + "%05d".format(index) + ".csv"
    val writer = new PrintWriter(file)
    println(file)

    for(
        month <- (1 to 12);
        day <- (1 to 30);
        hour <- (0 to 23);
        min <- (0 to 59 by 5)){
            writer.println(
                "%d/%02d/%02d".format(2013, month, day) +
                "," +
                "%02d:%02d".format(hour, min) +
                "," +
                "%dW".format(Random.nextInt(100).abs)
            )
    }
    writer.close()
}


