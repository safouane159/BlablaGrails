<%@ page contentType="text/html;charset=UTF-8" %>
<html class="loading" lang="en" data-textdirection="ltr">
<!-- BEGIN: Head-->

<head>
    <title>BlaBla Grails</title>
    <meta name="layout" content="backoffice-main"/>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!-- BEGIN: VENDOR CSS-->

    <!-- END: VENDOR CSS-->
    <!-- BEGIN: Page Level CSS-->

    <!-- END: Page Level CSS-->
    <!-- END: Custom CSS-->
    <asset:stylesheet src="materialize.css"/>


    <asset:stylesheet src="vendors.min.css"/>



    <asset:stylesheet src="select2.min.css"/>
    <asset:stylesheet src="select2-materialize.css"/>
    <asset:stylesheet src="style.css"/>


    <asset:stylesheet src="page-account-settings.css"/>


</head>
<!-- END: Head-->

<body class="vertical-layout page-header-light vertical-menu-collapsible vertical-dark-menu preload-transitions 2-columns   " data-open="click" data-menu="vertical-dark-menu" data-col="2-columns">

<!-- BEGIN: Header-->

<!-- END: Header-->





<!-- END: SideNav-->

<!-- BEGIN: Page Main-->

    <div class="row">
        <div class="content-wrapper-before blue-grey lighten-5"></div>
        <div id="breadcrumbs-wrapper" class=" imagebg ">
            <!-- Search for small screen-->
            <div class="container">
                <div class="row">
                    <div class="col s12 m6 l6">
                        <h5 class="breadcrumbs-title mt-0 mb-0"><span>Account Settings</span></h5>
                    </div>
                    <div class="col s12 m6 l6 right-align-md">
                        <ol class="breadcrumbs mb-0">
                            <li class="breadcrumb-item"><a href="index.html">Home</a>
                            </li>
                            <li class="breadcrumb-item"><a href="#">Pages</a>
                            </li>
                            <li class="breadcrumb-item active">Page Account Settings
                            </li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
        <div class="col s12">
            <div class="container">
                <!-- Account settings -->
                <section class="tabs-vertical mt-1 section">
                    <div class="row">
                        <div class="col l4 s12">
                            <!-- tabs  -->
                            <div class="card-panel">
                                <ul class="tabs">
                                    <li class="tab">
                                        <a href="#general">
                                            <i class="material-icons">brightness_low</i>
                                            <span>General</span>
                                        </a>
                                    </li>


                                </ul>
                            </div>
                        </div>
                        <div class="col l8 s12">
                            <!-- tabs content -->
                            <div id="general">
                                <div class="card-panel">

                                    <form class="formValidate" id="updateUser"  method="get">
                                        <div class="row">
                                            <div class="col s12">
                                                <div class="row">
                                                    <div class="input-field col s12">
                                                        <input id="username" name="username" type="text" class="validate"
                                                               value="${(users) ? users.username : ""}">
                                                        <label for="username" class="${(users) ? "active" : ""}">Username</label>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="input-field col s6">
                                                        <input id="nomComplet" name="nomComplet" type="text" class="validate"
                                                               value="${(users) ? users.nomComplet : ""}">
                                                        <label for="nomComplet" class="${(users) ? "active" : ""}">Nom Complet</label>
                                                    </div>

                                                    <div class="input-field col s6">
                                                        <input id="tel" name="tel" type="text" class="validate"
                                                               value="${(users) ? users.tel : ""}">
                                                        <label for="tel" class="${(users) ? "active" : ""}">Numéro de telephone</label>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="input-field col s12">
                                                        <input id="mail" name="mail" type="email" class="validate"
                                                               value="${(users) ? users.mail : ""}">
                                                        <label for="mail" class="${(users) ? "active" : ""}">Email</label>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="input-field col s6">
                                                        <input id="password" name="password" type="password" class="validate"
                                                               value="">
                                                        <label for="password" class="">Mot de passe</label>
                                                    </div>

                                                    <div class="input-field col s6">
                                                        <input id="confirm_password" name="confirm_password" type="password" class="validate"
                                                               value="">
                                                        <label for="confirm_password" class="">Confirmation mot de passe</label>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="input-field col s12">
                                                        <input id="aboutme" name="aboutme" type="text" class="validate"
                                                               value="${(users) ? users.aboutme : ""}">
                                                        <label for="aboutme" class="${(users) ? "active" : ""}">About me</label>
                                                    </div>
                                                </div>



                                                    <div class="col s12 display-flex justify-content-end form-action">
                                                        <button form="updateUser"
                                                                type="submit" name="action"class="btn indigo waves-effect waves-light mr-2">
                                                            Save changes
                                                        </button>
                                                        <button  class="btn btn-light-pink waves-effect waves-light mb-1">Cancel</button>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>


                                    </form>





                                </div>
                            </div>

                        </div>
                    </div>
                </section><!-- START RIGHT SIDEBAR NAV -->

            <!-- END RIGHT SIDEBAR NAV -->
            </div>
            <div class="content-overlay"></div>
        </div>
    </div>

<!-- END: Page Main-->

<!-- BEGIN: Footer-->
<script>
    var successMsg = "Vos données sont à jour! ";
    var errorMsg = "Oups... un problème est survenu ";
    const form  = document.getElementById('updateUser');

    form.addEventListener('submit', (event) => {
        event.preventDefault();
        // stop form submission

        var formData = {
            nomComplet: $("#nomComplet").val(),
            username: $("#username").val(),
            tel: $("#tel").val(),
            mail: $("#mail").val(),
            password: $("#password").val(),
            aboutme: $("#aboutme").val()

        };

        $.ajax({
            type: "PUT",
            url: "updateuser",
            data: formData,
            dataType: "json",
            encode: true,
        }).done(function (data) {

            swal("Success", successMsg, "success");
            setTimeout(() => {
                location.reload();
            }, 2000);
        });

    });
</script>
<asset:javascript src="vendors.min.js"/>
<asset:javascript src="plugins.js"/>
<asset:javascript src="search.js"/>
<asset:javascript src="custom-script.js"/>
<asset:javascript src="sweetalert.min.js"/>
<!-- END: Footer-->
<asset:javascript src="select2.full.min.js"/>
<asset:javascript src="jquery.validate.min.js"/>
<asset:javascript src="page-account-settings.js"/>
<asset:javascript src="sweetalert.min.js"/>

<!-- END PAGE LEVEL JS-->
</body>

</html>