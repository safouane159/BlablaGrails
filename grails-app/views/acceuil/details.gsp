<%@ page contentType="text/html;charset=UTF-8" %>
<html class="loading" lang="en" data-textdirection="ltr">
<!-- BEGIN: Head-->

<head>

    <title>BlaBla Grails</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <asset:stylesheet src="vendors.min.css"/>



    <asset:stylesheet src="materialize.css"/>
    <asset:stylesheet src="style.css"/>


    <asset:stylesheet src="page-account-settings.css"/>
    <asset:stylesheet src="custom.css"/>





    <sec:ifNotLoggedIn>

        <meta name="layout" content="Frontoffice-main"/>
    </sec:ifNotLoggedIn>
    <sec:ifLoggedIn>
        <meta name="layout" content="backoffice-main"/>
    </sec:ifLoggedIn>
<!-- END: Custom CSS-->
</head>
<!-- END: Head-->

<body>

<div id="breadcrumbs-wrapper" class=" imagebg ">
    <!-- Search for small screen-->
    <div class="container">
        <div class="row">
            <div class="col s12 m6 l6 ">
                <h5 class="breadcrumbs-title mt-0 mb-0"><span>Details annocne</span></h5>
            </div>

            <div class="col s12 m6 l6 right-align-md">
                <ol class="breadcrumbs mb-0">
                    <li class="  breadcrumb-item "><a class="forwhite" href="/">Acceuil</a>
                    </li>

                    <li class="breadcrumb-item active forwhite"><a class="forwhite" href="/acceuil"> List des annonces</a>
                    </li>
                    <li class="breadcrumb-item active forwhite">Details annonce
                    </li>
                </ol>
            </div>
        </div>
    </div>
</div>
<!-- BEGIN: Header-->

<!-- END: Header-->



<!-- END: SideNav-->

<!-- BEGIN: Page Main-->


<div class="col s12">
    <div class="container">
        <!-- Account settings -->
        <section class="tabs-vertical mt-1 section">
            <div class="row">
                <div class="col l4 s12">
                    <!-- tabs  -->
                    <div class="card-panel">
                        <h5><i class="material-icons purple-text vertical-text-bottom">phone</i> Contact vendeur</h5>

                        <div id="profile-card" class="card">

                            <div class="card-image waves-effect waves-block waves-light" style="background-color: gray">

                            </div>

                            <div class="card-content">
                                <input type="hidden" value="${annonce.lat}" id="lat">

                                <input type="hidden" value="${annonce.lng}" id="lng">

                                <g:img dir="images" file="default_avatar.jpg" alt="avatar"
                                       class="circle responsive-img activator card-profile-image cyan lighten-1 padding-2"/>

                                <h5 class="card-title activator grey-text text-darken-4">${annonce.author.username}</h5>

                                <p><i class="material-icons profile-card-i">perm_identity</i> ${annonce.author.nomComplet}
                                </p>

                                <p><i class="material-icons profile-card-i">perm_phone_msg</i> ${annonce.author.tel}</p>

                                <p><i class="material-icons profile-card-i">email</i> ${annonce.author.mail}</p>
                            </div>

                            <div class="card-reveal">
                                <span class="card-title grey-text text-darken-4">${annonce.author.username}<i
                                        class="material-icons right">close</i>
                                </span>

                                <p>${annonce.author.aboutme}</p>

                                <p><i class="material-icons">perm_identity</i> ${annonce.author.nomComplet}</p>

                                <p><i class="material-icons">perm_phone_msg</i>  ${annonce.author.tel}</p>

                                <p><i class="material-icons">email</i> ${annonce.author.mail}</p>

                            </div>
                        </div>
                    </div>
                </div>

                <div class="col l8 s12">
                    <!-- tabs content -->
                    <div id="general">
                        <div class="card-panel">

                            <h5><i class="material-icons purple-text vertical-text-bottom">local_offer</i> Item details
                            </h5>

                            <div class="card-content">
                                <div class="row" id="product-four">
                                    <div class="col m12 s12">

                                        <div class="carousel">
                                            <g:each  var="illu"  in="${annonce.illustrations}">
                                            <a class="carousel-item" href="#one!">
                                                <img src="https://s3.eu-west-3.amazonaws.com/blablagrails/illustration/${illu.filename}"/>
</a>

                                            </g:each>


                                        </div>

                                    </div>

                                    <div class="row">
                                        <div class="divtocenter"><h5>${annonce.title}</h5></div>

                                        <div class="col m2 s6 tocolor">
                                            <p>Prix :</p>

                                            <p>Date de creation :</p>


                                            <p>Availability:</p>
                                            <hr class="mb-5">


                                            <p>Details de l'annonce :</p>

                                        </div>

                                        <div class="col m6 s12 ">
                                            <p>${annonce.price}  €</p>

                                            <p>${annonce.dateCreated}</p>


                                            <p><span class="green-text">Available</span></p>
                                            <hr class="mb-5">


                                            <p style="overflow-wrap: break-word;">${annonce.description}</p>

                                        </div>
                                    </div>
                                </div>

                                <div id="map"></div>
                            </div>

                            <div class="divider mb-1 mt-1"></div>

                        </div>
                    </div>

                </div>
            </div>
        </section><!-- START RIGHT SIDEBAR NAV -->

    <!-- END RIGHT SIDEBAR NAV -->
    </div>

    <div class="content-overlay"></div>
</div>



<!-- END: Footer-->
<!-- BEGIN VENDOR JS-->

<asset:javascript src="page-account-settings.js"/>


<asset:javascript type="module" src="indexmap.js"/>

<asset:javascript src="https://polyfill.io/v3/polyfill.min.js?features=default"/>
<script>

    const lat1 = document.getElementById('lat').value;
    const lng1 = document.getElementById('lng').value;
    console.log(lat);


    function initMap() {
        // The location of Uluru
        const uluru = {lat: parseFloat(lat1) , lng: parseFloat(lng1)};
        console.log(uluru)
        // The map, centered at Uluru
        const map = new google.maps.Map(document.getElementById("map"), {
            zoom: 4,
            center: uluru,
        });
        // The marker, positioned at Uluru
        const marker = new google.maps.Marker({
            position: uluru,
            map: map,
        });
    }

    window.initMap = initMap;
</script>

<script
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBQPp7AO7gZnITRW8abEMxb8Y9H7sXrfro&callback=initMap&v=weekly"
        defer></script>
<asset:javascript src="vendors.min.js"/>
<asset:javascript src="plugins.js"/>
<asset:javascript src="search.js"/>
<asset:javascript src="custom-script.js"/>
</body>

</html>