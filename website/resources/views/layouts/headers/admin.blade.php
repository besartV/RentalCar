@include('layouts.headers.head')
<body id="app-layout">
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="index.html">RENTAL CAR - ADMIN PANEL</a>
    </div>
    <!-- Top Menu Items -->
    <ul class="nav navbar-right top-nav" id="admin-logout">
        <li><a href="{{ url('/logout') }}"><i class="fa fa-btn fa-sign-out"></i>{{Auth::user()->name }} Logout</a></li>
    </ul>
    <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
    <div class="collapse navbar-collapse navbar-ex1-collapse">
        <ul class="nav navbar-nav side-nav">
            <li>
                <a href="{{ url('/admin') }}"><i class="fa fa-fw fa-dashboard"></i> Dashboard</a>
            </li>
            <li>
                <a href="{{ url('/admin/users') }}"><i class="fa fa-fw fa-users"></i> Users</a>
            </li>
            <li>
                <a href="{{ url('/admin/cars') }}"><i class="fa fa-fw fa-car"></i> Cars</a>
            </li>
            <li>
                <a href="{{ url('/admin/locations') }}"><i class="fa fa-fw fa-location-arrow"></i> Locations</a>
            </li>
            <li>
                <a href="{{ url('/') }}">Original website</a>
            </li>
        </ul>
    </div>
    <!-- /.navbar-collapse -->
</nav>