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
                            onclick="_formUsers(0)"><i
                            class="material-icons left">add</i>CRÉER UTILISATEUR</button>

                </div>

                <div class="responsive-table">
                    <table class="table invoice-data-table white border-radius-4 pt-1" id="users_datatable">
                        <thead>
                        <tr>
                            <!-- data table responsive icons -->
                            <th>ID#</th>
                            <!-- data table checkbox -->
                            <th>
                                <span>Username</span>
                            </th>
                            <th>
                                <span>Nom complet</span>
                            </th>
                            <th>
                                <span>Email</span>
                            </th>
                            <th>
                                <span>Tel</span>
                            </th>
                            <th>Nombres d'annonces</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                        </thead>

                        <tbody>

                        <g:each in="${users}">
                            <tr>
                                <td>${it.id}</td>
                                <td>
                                    <span>${it.username}</span>
                                </td>
                                <td>
                                    <span>${it.nomComplet}</span>
                                </td>
                                <td>
                                    <span class="chip lighten-5 red black-text">${it.mail}</span>
                                </td>
                                <td>
                                    <span class="chip lighten-5 green green-text">${it.tel}</span>
                                </td>
                                <td>
                                    <span class="chip lighten-5 blue blue-text">${(it.annonces) ? it.annonces.size() : 0} annonces</span>
                                </td>
                                <td>
                                    <g:if test="${it.enabled}">
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
                                        <b class="invoice-action-view hand-cursor mr-4">
                                            <i class="material-icons">remove_red_eye</i>
                                        </b>
                                        <a onclick="_formUsers(${it.id});"
                                           class="invoice-action-edit hand-cursor mr-4">
                                            <i class="material-icons">edit</i>
                                        </a>
                                        <a onclick="_deleteUsers(${it.id});"
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
<div id="modal_user" class="modal modal-fixed-footer">
    <div class="modal-content" id="modal_content_user">
        <form id="form_user" action="createUser">
            <div id="form_userContent">

            </div>
        </form>
    </div>

    <div class="modal-footer">
        <button class="btn waves-effect waves-light red accent-2 left modal-action modal-close btn-small mr-1"
                type="button">Annuler
            <i class="material-icons left">close</i>
        </button>
        <button class="btn waves-effect waves-light green right btn-small" form="form_user"
                type="submit" name="action">Enregistrer
            <i class="material-icons left">save</i> <span id="span_btn_submit_form_user"></span>
        </button>
    </div>
</div>
<!--END-MODAL-->

<script type="text/javascript">
    $.ajaxSetup({
        headers: {
            "X-CSRF-TOKEN": $('meta[name="csrf-token"]').attr("content"),
        },
    });

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
            /*$("#span_btn_submit_formsales_reports").html('<i class="fa fa-spinner fa-spin"></i>');
            var formData = $(form).serializeArray(); // convert form to array
            $.ajax({
                type: "POST",
                url: "/form/pharmacy/sale",
                data: formData,
                dataType: "JSON",
                success: function(result) {
                    if (result.success) {
                        swal("{{ __('locale.success') }}", result.msg, "success");
                        $("#modal_sales_reports").modal("close");
                        //alert("response.type");
                        if (result.type == 0) {

                            setTimeout(() => {
                                _formsales_reports(result.id);
                            }, 2000);
                        }

                    } else {
                        swal("{{ __('locale.error') }}", result.msg, "error");
                    }
                },
                error: function(error) {
                    swal("{{ __('locale.error') }}", "Oooops...", "error");
                },
                complete: function(resultat, statut) {
                    $("#span_btn_submit_formsales_reports").html("");
                    _reload_sales_reports_datatable();
                },
            });
            return false;*/
        },
    });


    function _formUsers(id) {
        //initialize all modals
        $('.modal').modal({
            dismissible: true
        });
        //var preloader = `<x-preloader />`;

        //call the specific div (modal)
        $("#modal_user").modal("open");

        // ID = 0 => CREATE
        //ID > 0 => UPDATE
        $("#form_user_id").val(id);

        //$("#formsales_reportsContent").html(preloader);

        $.ajax({
            url: "/admin/form_user_admin/" + id,
            type: "GET",
            dataType: "html",
            success: function (html, status) {
                $("#form_userContent").html(html);
            },
        });
    }


    function _deleteUsers(id) {
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
            swal("Erreur", "Merci de sélectionner les utilisateurs à supprimer", "error");
        } else {
            var successMsg = "L'utilisateur a été bien supprimé";
            var errorMsg = "Oups... L'utilisateur n'est pas été supprimer";
            var swalConfirmTitle = "Confirmation de suppression";
            var swalConfirmText = "Olaa... Voulez-vous vraiment supprimer cet utilisateur";
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
                        url: "/user/delete/" + id,
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