@include('layouts.headers.admin')
@yield('content')
<footer>
    <div id="wrapper">
        <div id="page-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="page-header">

                        </div>
                        <p class="text-center">Copyright <a href="http://www.yseemonnier.com" target="_blank">Ysée Monnier</a> & Besart Vishesella</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</footer>

<!-- JavaScripts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script src="{{ url('js/angular.js') }}"></script>
<script src="http://maps.google.com/maps/api/js"></script>
<script src="{{ url('js/app.js') }}"></script>
<script src="{{ url('js/clndr.min.js') }}"></script>
</body>
</html>
