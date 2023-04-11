<html class="loading" lang="en" data-textdirection="ltr">
<!-- BEGIN: Head-->

<head>
    <meta name="layout" content="${gspLayout ?: 'main'}"/>

    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">

    <title>Connexion</title>


    <asset:stylesheet src="vendors.min.css"/>
    <asset:stylesheet src="materialize.css"/>
    <asset:stylesheet src="style.css"/>
    <asset:stylesheet src="register.css"/>
    <asset:stylesheet src="custom.css"/><!-- picture is here -->

</head>
<!-- END: Head-->

<body class="vertical-layout page-header-light vertical-menu-collapsible vertical-dark-menu preload-transitions 1-column register-bg   blank-page blank-page" data-open="click" data-menu="vertical-dark-menu" data-col="1-column">
<div class="row">
    <div class="col s12">
        <div class="container">
            <div id="register-page" class="row">
                <div class="col s12 m6 l4 z-depth-4 card-panel border-radius-6 register-card bg-opacity-8">
                    <form  action="${postUrl ?: '/login/authenticate'}" method="POST" id="loginForm" class="login-form" autocomplete="off" >
                        <div class="row">
                            <div class="input-field col s12">
                                <h5 class="ml-4">Connexion administrateur </h5>

                            </div>
                        </div>
                        <div class="row margin">
                            <div class="input-field col s12">
                                <i class="material-icons prefix pt-2">person_outline</i>
                                <input  type="text" class="text_" name="${usernameParameter ?: 'username'}" id="username" />
                                <label for="username" class="center-align">Username</label>
                            </div>
                        </div>

                        <div class="row margin">
                            <div class="input-field col s12">
                                <i class="material-icons prefix pt-2">lock_outline</i>
                                <input type="password" class="text_" name="${passwordParameter ?: 'password'}" id="password" />
                                <label for="password">Password</label>
                            </div>
                        </div>

                        <div class="row">
                            <div class="input-field col s12">
                                <input  type="submit" id="submit" value="Login" class="btn  border-round gradient-45deg-purple-deep-orange col s12 added" />
                            </div>
                        </div>

                    </form>
                </div>
            </div>
        </div>
        <div class="content-overlay"></div>
    </div>
</div>

<!-- END THEME  JS-->
<!-- BEGIN PAGE LEVEL JS-->
<!-- END PAGE LEVEL JS-->
<asset:javascript src="vendors.min.js"/>
<asset:javascript src="plugins.js"/>
<asset:javascript src="search.js"/>
</body>
<script>
    (function() {
        document.forms['loginForm'].elements['${usernameParameter ?: 'username'}'].focus();
    })();
</script>
</html>
