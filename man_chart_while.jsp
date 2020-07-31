<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8"); 
	String title = "펫밀리:기간별 차트";
%>

<!-- 차트 -->

	<canvas class="my-4 w-100" id="myChart" width="900" height="380"></canvas>

	<h2>Section title</h2>
	<div class="table-responsive">
		<table class="table table-striped table-sm">
			<thead>
				<tr>
					<th>#</th>
					<th>Header</th>
					<th>Header</th>
					<th>Header</th>
					<th>Header</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>1,001</td>
					<td>Lorem</td>
					<td>ipsum</td>
					<td>dolor</td>
					<td>sit</td>
				</tr>
				<tr>
					<td>1,002</td>
					<td>amet</td>
					<td>consectetur</td>
					<td>adipiscing</td>
					<td>elit</td>
				</tr>
				<tr>
					<td>1,003</td>
					<td>Integer</td>
					<td>nec</td>
					<td>odio</td>
					<td>Praesent</td>
				</tr>
				<tr>
					<td>1,003</td>
					<td>libero</td>
					<td>Sed</td>
					<td>cursus</td>
					<td>ante</td>
				</tr>
				<tr>
					<td>1,004</td>
					<td>dapibus</td>
					<td>diam</td>
					<td>Sed</td>
					<td>nisi</td>
				</tr>
				<tr>
					<td>1,005</td>
					<td>Nulla</td>
					<td>quis</td>
					<td>sem</td>
					<td>at</td>
				</tr>
				<tr>
					<td>1,006</td>
					<td>nibh</td>
					<td>elementum</td>
					<td>imperdiet</td>
					<td>Duis</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	
<!-- Bootstrap core JavaScript
    ================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery-slim.min.js"><\/script>')</script>
<script src="../../assets/js/vendor/popper.min.js"></script>
<script src="../../dist/js/bootstrap.min.js"></script>

<!-- Graphs -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.min.js"></script>
<script>
      var ctx = document.getElementById("myChart");
      var myChart = new Chart(ctx, {
        type: 'line',
        data: {
          labels: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
          datasets: [{
            data: [15339, 21345, 18483, 24003, 23489, 24092, 12034],
            lineTension: 0,
            backgroundColor: 'transparent',
            borderColor: '#007bff',
            borderWidth: 4,
            pointBackgroundColor: '#007bff'
          }]
        },
        options: {
          scales: {
            yAxes: [{
              ticks: {
                beginAtZero: false
              }
            }]
          },
          legend: {
            display: false,
          }
        }
      });
    </script>
