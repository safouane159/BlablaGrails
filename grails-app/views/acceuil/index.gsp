<%@ page contentType="text/html;charset=UTF-8" %>
<html >
<!-- BEGIN: Head-->

<head>
    <title>BlaBla Grails</title>

    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">


<!-- END: Custom CSS-->
    <asset:stylesheet src="vendors.min.css"/>



    <asset:stylesheet src="materialize.css"/>
    <asset:stylesheet src="style.css"/>


    <asset:stylesheet src="eCommerce-products-page.css"/>
    <asset:stylesheet src="nouislider.min.css"/>
    <asset:stylesheet src="custom.css"/>

    <sec:ifNotLoggedIn>
hello
        <meta name="layout" content="Frontoffice-main"/>
    </sec:ifNotLoggedIn>
    <sec:ifLoggedIn>
        walou
        <meta name="layout" content="backoffice-main"/>
    </sec:ifLoggedIn>
</head>
<!-- END: Head-->

<body>

<!-- BEGIN: Header-->






<!-- END: SideNav-->

<!-- BEGIN: Page Main-->


<div id="breadcrumbs-wrapper" class=" imagebg ">
    <!-- Search for small screen-->
    <div class="container">
        <div class="row">
            <div class="col s12 m6 l6 ">
                <h5 class="breadcrumbs-title mt-0 mb-0"><span>Decouvrir les annocnes</span></h5>
            </div>

            <div class="col s12 m6 l6 right-align-md">
                <ol class="breadcrumbs mb-0">
                    <li class="  breadcrumb-item "><a class="forwhite" href="/">Acceuil</a>
                    </li>

                    <li class="breadcrumb-item active forwhite">List des annonces
                    </li>
                </ol>
            </div>
        </div>
    </div>
</div>


<div class="container">
    <div class="section">
        <div class="row" id="ecommerce-products">

            <div class="col s6 m6 l9 pr-0 hamid">


                <g:each in="${annonces}">
                <div class="col s10">
                    <div class="card animate fadeUp">
                        <div class="card-badge"><a class="white-text"><b>On Offer</b></a></div>

                        <div class="card-content">
                            <div class="row" id="product-four">
                                <div class="col m4 s8">
                                    <div class="carousel">
                    <g:each  var="illu"  in="${it.illustrations}">

                                        <a class="carousel-item" href="#one!">
                                            <img src="https://s3.eu-west-3.amazonaws.com/blablagrails/illustration/${illu.filename}"/>

                                        </a>
                    </g:each>

                                    </div>


                                </div>

                                <div class="col m6 s12">
                                    <p>${it.author.username}</p>
                                    <h5>${it.title}</h5>
                                <span class="new badge left ml-0 mr-2" data-badge-caption="">${it.dateCreated}</span>
                                    <p>Availability: <span class="green-text">Available</span></p>
                                    <hr class="mb-5">


                                    <p style="overflow-wrap: break-word;">${it.description}</p>
                                <h5 class="red-text">${it.price} € </h5>

                                    <g:link class="waves-effect waves-light btn gradient-45deg-purple-deep-orange z-depth-4 mt-2"  action="details" controller="acceuil" id= "${it.id}" >Details Annonce</g:link>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                </g:each>



                <!-- Pagination -->
                <div class="col s12 center">
                    <ul class="pagination">
                        <li class="disabled">
                            <a href="#!">
                                <i class="material-icons">chevron_left</i>
                            </a>
                        </li>
                        <li class="active"><a href="#!">1</a>
                        </li>
                        <li class="waves-effect"><a href="#!">2</a>
                        </li>
                        <li class="waves-effect"><a href="#!">3</a>
                        </li>
                        <li class="waves-effect"><a href="#!">4</a>
                        </li>
                        <li class="waves-effect"><a href="#!">5</a>
                        </li>
                        <li class="waves-effect">
                            <a href="#!">
                                <i class="material-icons">chevron_right</i>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div><!-- START RIGHT SIDEBAR NAV -->

<!-- END RIGHT SIDEBAR NAV -->

</div>



<!-- END: Page Main-->


<!-- END PAGE LEVEL JS-->
<asset:javascript src="nouislider.min.js"/>
<asset:javascript src="advance-ui-modals.js"/>
<asset:javascript src="eCommerce-products-page.js"/>



<asset:javascript src="vendors.min.js"/>
<asset:javascript src="plugins.js"/>
<asset:javascript src="search.js"/>
<asset:javascript src="custom-script.js"/>
</body>

</html>