<!DOCTYPE html>
<html class="loading" lang="en" data-textdirection="ltr">
<!-- BEGIN: Head-->

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta name="description"
          content="Materialize is a Material Design Admin Template,It's modern, responsive and based on Material Design by Google.">
    <meta name="keywords"
          content="materialize, admin template, dashboard template, flat admin template, responsive admin template, eCommerce dashboard, analytic dashboard">
    <meta name="author" content="ThemeSelect">
    <title>lecoincoin - Administration</title>
    <link rel="apple-touch-icon" href="../app-assets/images/favicon/apple-touch-icon-152x152.png">
    <link rel="shortcut icon" type="image/x-icon" href="../app-assets/images/favicon/favicon-32x32.png">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">


    <asset:stylesheet src="vendors.min.css"/>
    <asset:stylesheet src="jquery.dataTables.min.css"/>
    <asset:stylesheet src="responsive.dataTables.min.css"/>
    <asset:stylesheet src="dataTables.checkboxes.css"/>
    <asset:stylesheet src="materialize.css"/>
    <asset:stylesheet src="style.css"/>
    <asset:stylesheet src="app-invoice.css"/>
    <asset:stylesheet src="custom.css"/>
</head>
<!-- END: Head-->

<body
        class="vertical-layout page-header-light vertical-menu-collapsible vertical-dark-menu preload-transitions 2-columns   "
        data-open="click" data-menu="vertical-dark-menu" data-col="2-columns">

<!-- BEGIN: Header-->
<header class="page-topbar" id="header">
    <div class="navbar navbar-fixed">

        <nav class="navbar-main navbar-color nav-collapsible sideNav-lock navbar-light">

            <div class="nav-wrapper">
                <ul class="lefta">
                    <li>
                        <a href="/">
                            <g:img dir="images" file="logo.png" width="120" height="60"/></a>
                    </li>

                </ul>

                <div class="righta header-search-wrapper hide-on-med-and-down "><i class="material-icons">search</i>
                    <input class="header-search-input z-depth-2" type="text" name="Search" placeholder="Recherche"
                           data-search="template-list">
                    <ul class="search-list collection display-none"></ul>
                </div>
                <ul class="navbar-list right">

                    <li class="hide-on-med-and-down"><a
                            class="waves-effect waves-block waves-light toggle-fullscreen"
                            href="javascript:void(0);"><i class="material-icons">settings_overscan</i></a></li>

                    <li class="hide-on-med-and-down"><a
                            class="waves-effect waves-block waves-light toggle-fullscreen"
                            href="javascript:void(0);"><g:link controller='login' action='auth'>Login</g:link></a></li>

                </ul>

                <!-- notifications-dropdown-->
                <ul class="dropdown-content" id="notifications-dropdown">
                    <li>
                        <h6>NOTIFICATIONS<span class="new badge">5</span></h6>
                    </li>
                    <li class="divider"></li>

                </ul>
                <!-- profile-dropdown-->
                <ul class="dropdown-content" id="profile-dropdown">
                    <li><a class="grey-text text-darken-1" href="user-profile-page.html"><i
                            class="material-icons">person_outline</i> Profile</a></li>
                    <!--    <li><a class="grey-text text-darken-1" href="app-chat.html"><i
                            class="material-icons">chat_bubble_outline</i> Chat</a></li>
                 <li><a class="grey-text text-darken-1" href="page-faq.html"><i
                            class="material-icons">help_outline</i> Help</a></li>
                    <li class="divider"></li>
                  <li><a class="grey-text text-darken-1" href="user-lock-screen.html"><i
                            class="material-icons">lock_outline</i> Lock</a></li> -->
                    <li><a class="grey-text text-darken-1"
                           href="${createLink(controller: 'Logout', action: 'index')}"><i
                                class="material-icons">keyboard_tab</i> Logout</a></li>
                </ul>
            </div>
            <nav class="display-none search-sm">
                <div class="nav-wrapper">
                    <form id="navbarForm">
                        <div class="input-field search-input-sm">
                            <input class="search-box-sm mb-0" type="search" required="" id="search"
                                   placeholder="Explore Materialize" data-search="template-list">
                            <label class="label-icon" for="search"><i
                                    class="material-icons search-sm-icon">search</i></label><i
                                class="material-icons search-sm-close">close</i>
                            <ul class="search-list collection search-list-sm display-none"></ul>
                        </div>
                    </form>
                </div>
            </nav>
        </nav>
    </div>
</header>
<!-- END: Header-->



<!-- BEGIN: SideNav-->

<!-- END: SideNav-->

<!-- BEGIN: Page Main-->
<g:layoutBody/>

<!-- END: Page Main-->

<!-- BEGIN: Footer-->

<footer class=" footercss page-footer footer footer-static footer-light navbar-border navbar-shadow">
    <div class="footer-copyright">
        <div class="container"><span>&copy; 2022 <a href="https://univ-cotedazur.eu/" target="_blank">Université
        Côte d'Azur</a> All rights reserved.</span><span class="right hide-on-small-only">Design and
        Developed by <a href="https://www.linkedin.com/in/safouane-ouazri/">OUAZRI Safouane</a> & <a
                href="https://www.linkedin.com/in/oussamasamia/">SAMIA Oussama</a></span></div>
    </div>
</footer>


<asset:javascript src="application.js"/>
<asset:javascript src="vendors.min.js"/>
<asset:javascript src="jquery.dataTables.min.js"/>
<asset:javascript src="dataTables.responsive.min.js"/>
<asset:javascript src="datatables.checkboxes.min.js"/>
<asset:javascript src="plugins.js"/>
<asset:javascript src="search.js"/>
<asset:javascript src="custom-script.js"/>
<asset:javascript src="sweetalert.min.js"/>

%{--
<asset:javascript src="app-invoice.js"/>
--}%

</body>

</html>