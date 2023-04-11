<%--
  Created by IntelliJ IDEA.
  User: safouaneouazri
  Date: 28/09/2022
  Time: 13:49
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="backoffice-main"/>
    <title></title>

</head>

<div class="row">
    <div class="content-wrapper-before blue-grey lighten-5"></div>

    <div class="col s12">
        <div class="container">
            <!-- invoice list -->
            <section class="invoice-list-wrapper section">

                <!-- create user button-->
                <div class="card-panel">

                    <button class="btn waves-effect waves-light btn-small" type="button"
                            onclick="_formAnnonces(0)"><i
                            class="material-icons left">add</i>CRÉER ANNONCE</button>

                </div>

                <div class="responsive-table">
                    <table class="table invoice-data-table white border-radius-4 pt-1" id="users_datatable">
                        <thead>
                        <tr>
                            <!-- data table responsive icons -->
                            <th>ID#</th>
                            <!-- data table checkbox -->
                            <th>
                                <span>Titre</span>
                            </th>
                            <th>
                                <span>Description</span>
                            </th>
                            <th>
                                <span>Prix</span>
                            </th>

                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                        </thead>

                        <tbody>

                        <g:each in="${annonces}">
                            <tr>
                                <td>${it.id}</td>
                                <td>
                                    <span>${it.title}</span>
                                </td>
                                <td>
                                    <span>${it.description}</span>
                                </td>
                                <td>
                                    <span class="chip lighten-5 green black-text">${it.price} €</span>
                                </td>
                                <td>
                                    <g:if test="${it.active}">
                                        <span class="bullet green"></span>
                                        <small>Activé</small>
                                    </g:if>

                                    <g:else>
                                        <span class="bullet red"></span>
                                        <small>Désactivé</small>
                                    </g:else>
                                </td>
                                <td>
                                    <div class="invoice-action">
                                        <a onclick="_formAnnonces(${it.id});"
                                           class="invoice-action-edit hand-cursor mr-4">
                                            <i class="material-icons">edit</i>
                                        </a>
                                        <a onclick="_deleteAnnonces(${it.id});"
                                           class="grey-text hand-cursor"><i class="material-icons">delete</i></a>

                                    </div>
                                </td>
                            </tr>

                        </g:each>
                        </tbody>
                    </table>

                </div>
            </section>
        </div>
    </div>
</div>


<!--MODAL-->
<div id="modal_annonce" class="modal modal-fixed-footer">

    <div class="modal-content" id="modal_content_user">
        <form id="form_user">
            <div id="form_annonceContent">

            </div>

            <div class="row">
                <div class="col s1"></div>

                <div class="col s10">
                    <div id="map"></div>
                </div>
            </div>
        </form>
    </div>

    <div class="modal-footer">

        <button onclick="location.reload()"
                class="btn waves-effect waves-light red accent-2 left modal-action modal-close btn-small mr-1"
                type="button">Annuler
            <i class="material-icons left">close</i>
        </button>
        <button class="btn waves-effect waves-light green right btn-small"
                type="submit" name="action" onclick="submit_form()">Enregistrer
            <i class="material-icons left">save</i> <span id="span_btn_submit_form_user"></span>
        </button>
    </div>

</div>
<!--END-MODAL-->


<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBQPp7AO7gZnITRW8abEMxb8Y9H7sXrfro&callback=initMap&v=weekly"
        defer></script>

<script>



    const form = document.getElementById('form_user');

    function boucle(i, tab, idA) {
        var myId = 0
        if (idA != 0) {
            myId = idA
        } else {

            myId = $('#id').val()
        }

        if (i >= 0) {
            tab = []
            tab.push(images_to_send[i])
            console.log(tab)
            var formData1 = {


                Illustration: JSON.stringify(tab),
                id: myId,
                title: $('#title').val(),
                description: $('#description').val(),
                price: $('#price').val(),
                active: $('#active').is(':checked'),
                user: $('#user').val(),
                address: $('#address').val(),
                lat: $('#lat').val(),
                lng: $('#lng').val(),

            }

            $.ajax({
                type: "POST",
                url: "/admin/createAnnonce",
                dataType: "JSON",
                data: formData1,
                encode: false,
                success: function (result, status) {

                    console.log("idA" + idA)
                    console.log("tab" + tab)
                    console.log("idA" + i)
                    boucle(i - 1, tab, idA)


                },
            });
        } else {


            setTimeout(() => {
                location.reload()
            }, 2000);


        }

    }


    function submit_form() {
        swal("Enregistré avec success", "", "success");
        document.getElementById("illustration")

        var i = images_to_send.length

        var formData2 = {

            id: $('#id').val()

        }
        if ($('#id').val() == 0) {
            //create
            var tab = [];

            console.log(typeof JSON.stringify(tab))
            var formData = {
                id: $('#id').val(),
                Illustration: JSON.stringify(tab),
                title: $('#title').val(),
                description: $('#description').val(),
                price: $('#price').val(),
                active: $('#active').is(':checked'),
                user: $('#user').val(),
                address: $('#address').val(),
                lat: $('#lat').val(),
                lng: $('#lng').val(),

            }

            $.ajax({
                type: "POST",
                url: "/admin/createAnnonce",
                dataType: "JSON",
                data: formData,
                encode: false,
                success: function (result, status) {

                    console.log("ha result "+result)
                       boucle(i - 1, tab,result)
                },
            });

        } else {
            var tab = [];
            //update
            $.ajax({
                type: "POST",
                url: "/admin/deleteAllIllustrations",
                dataType: "JSON",
                data: formData2,
                encode: false,
                success: function (result, status) {
                    boucle(i - 1, tab, 0)

                },
            });


        }


    }


    function fofo() {

        setTimeout(function () {

            // Getting the address from the text input
            var address = document.getElementById('address').value;

            // Making the Geocoder call
            getCoordinates(address);

            // Preventing the form from doing a page submit
            return false;
        }, 3000);
    }

    var map, geocoder, marker, infowindow;
    (function () {

        // Defining some global variables


        window.onload = function () {

            // Creating a new map
            var options = {
                zoom: 3,
                center: new google.maps.LatLng(37.09, -95.71),
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };

            map = new google.maps.Map(document.getElementById('map'), options);

            // Getting a reference to the HTML form
            //   var form = document.getElementById('addressForm');

            // Catching the forms submit event


        }

        // Create a function the will return the coordinates for the address


    })();

    function getCoordinates(address) {
        // Check to see if we already have a geocoded object. If not we create one
        if (!geocoder) {
            geocoder = new google.maps.Geocoder();
        }

        // Creating a GeocoderRequest object
        var geocoderRequest = {
            address: address
        }

        // Making the Geocode request
        geocoder.geocode(geocoderRequest, function (results, status) {

            // Check if status is OK before proceeding
            if (status == google.maps.GeocoderStatus.OK) {

                // Center the map on the returned location
                map.setCenter(results[0].geometry.location);

                // Check to see if we've already got a Marker object
                if (!marker) {
                    // Creating a new marker and adding it to the map
                    marker = new google.maps.Marker({
                        map: map
                    });
                }

                // Setting the position of the marker to the returned location
                marker.setPosition(results[0].geometry.location);

                // Check to see if we've already got an InfoWindow object
                if (!infowindow) {
                    // Creating a new InfoWindow
                    infowindow = new google.maps.InfoWindow();
                }

                // Creating the content of the InfoWindow to the address
                // and the returned position
                var content = '<strong>' + results[0].formatted_address + '</strong><br />';
                content += 'Lat: ' + results[0].geometry.location.lat() + '<br />';
                content += 'Lng: ' + results[0].geometry.location.lng();


                // Adding the content to the InfoWindow
                infowindow.setContent(content);

                // Opening the InfoWindow
                infowindow.open(map, marker);


                document.getElementById('lat').value = results[0].geometry.location.lat();

                document.getElementById('lng').value = results[0].geometry.location.lng();


            }

        });

    }
</script>
<script type="text/javascript">

    $(document).ready(function () {
        // the "href" attribute of the modal trigger must specify the modal ID that wants to be triggered

    });


    //Validate form
    $("#form_user").validate({
        rules: {
            username: {
                required: true
            }
        },
        messages: {},
        submitHandler: function (form) {

            console.log("form submited");

        },
    });


    function _formAnnonces(id) {
        //initialize all modals
        $('.modal').modal({
            dismissible: true
        });

        $("#modal_annonce").modal("open");


        $.ajax({
            url: "/admin/form_annonce_admin/" + id,
            type: "GET",
            dataType: "html",
            success: function (html, status) {
                $("#form_annonceContent").html(html);
            },
        });
    }


    function _deleteAnnonces(id) {

        var arrayIds = new Array();
        var j = 0;
        if (id > 0) {
            arrayIds[0] = id;
        } else {
            $('#sales_reports_datatable input[class="checkable"]').each(function () {
                var checked = jQuery(this).is(":checked");
                if (checked) {
                    arrayIds[j] = jQuery(this).val();
                    j++;
                }
            });
        }
        if (arrayIds.length < 1) {
            swal("Erreur", "Merci de sélectionner les annonces à supprimer", "error");
        } else {
            var successMsg = "L'annonce a été bien supprimée";
            var errorMsg = "Oups... L'annonce n'est pas été supprimer";
            var swalConfirmTitle = "Confirmation de suppression";
            var swalConfirmText = "Olaa... Voulez-vous vraiment supprimer cette annonce";
            swal({
                title: swalConfirmTitle,
                text: swalConfirmText,
                icon: 'warning',
                dangerMode: true,
                buttons: {
                    cancel: "Non",
                    delete: "Oui"
                }
            }).then(function (willDelete) {

                if (willDelete) {

                    $.ajax({
                        url: "/annonce/delete/" + id,
                        type: "DELETE",
                        cache: false,
                        data: {
                            ids: arrayIds
                        },
                        dataType: "JSON",
                        success: function (result, status) {
                            swal("Success", successMsg, "success");
                            setTimeout(() => {
                                 location.reload();
                            }, 2000);

                        },
                        error: function (result, status, error) {
                            swal("Error", errorMsg, "error");
                        },
                        complete: function (result, status) {
                            //_reload_sales_reports_datatable();
                        },
                    });

                }
            });
        }

    }
</script>

</html>