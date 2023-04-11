<%@ page import="groovy.json.JsonOutput" %>
<head>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <style>
    #map {
        height: 400px;
        /* The height is 400 pixels */
        width: 100%;
        /* The width is the width of the web page */
    }
    </style>
</head>
<h4>${(annonce) ? "Modification annonce" : "Création annonce"}</h4>
<input type="hidden" name="id" id="id" value="${(annonce) ? annonce.id : 0}"/>


<div class="row">
    <div class="col s12">

        <div class="row">
            <div class="input-field col s12">

                <input type="file" id="illustration" name="illustration" accept="image/png, image/gif, image/jpeg"
                       multiple="multiple"
                       class="dropify" data-default-file="" onchange="image_change(event)"/>
            </div>

            <g:if test="${annonce}">
                <div hidden>
                    <ul id="images_from_db">
                        <g:each in="${annonce.illustrations}">
                            <li>${"https://s3.eu-west-3.amazonaws.com/blablagrails/illustration/" + it.filename}</li>
                        </g:each>
                    </ul>
                </div>
            </g:if>
            <div class="input-field col s12" id="images_html">

            </div>
        </div>

        <div class="row">
            <div class="input-field col s12">
                <input id="title" name="title" type="text" class="validate"
                       value="${(annonce) ? annonce.title : ""}">
                <label for="title" class="${(annonce) ? "active" : ""}">Title</label>
            </div>
        </div>

        <div class="row">
            <div class="input-field col s12">
                <input id="description" name="description" type="text" class="validate"
                       value="${(annonce) ? annonce.description : ""}">
                <label for="description" class="${(annonce) ? "active" : ""}">Description</label>
            </div>
        </div>

        <div class="row">
            <div class="input-field col s6">
                <input id="price" name="price" type="number" class="validate"
                       value="${(annonce) ? annonce.price : ""}">
                <label for="price" class="${(annonce) ? "active" : ""}">Price</label>
            </div>

            <div class="input-field col s6">
                <div>
                    <label>Status</label>
                </div>

                <div class="switch">
                    <label>
                        Désactivé
                        <input type="checkbox" name="active"
                               id="active" ${(annonce) ? (annonce.active) ? "checked" : "" : ""}>
                        <span class="lever"></span>
                        Activé
                    </label>
                </div>
            </div>
        </div>
        <sec:ifAllGranted roles='ROLE_ADMIN'>
            <div class="row">

                <div class="input-field col s12">

                    <div class="input-field">
                        <select name="user" id="user" class="select2 browser-default">
                            <g:each in="${users}">
                                <option value="${it.id}">@${it.username} - ${it.nomComplet}</option>
                            </g:each>
                        </select>
                    </div>
                </div>

            </div>
        </sec:ifAllGranted>

        <sec:ifAllGranted roles='ROLE_CLIENT'>
            <input type="hidden" name="user" id="user" value="2"/>

        </sec:ifAllGranted>
        <div class="row">
            <div class="input-field col s12">

                <input type="text" name="address" id="address" class="validate"
                       value="${(annonce) ? annonce.address : ""}" onkeypress="fofo()"/>
                <label for="address" class="${(annonce) ? "active" : ""}">Address</label>


                <input type="hidden" name="lat" id="lat" value="${(annonce) ? annonce.lat : ""}"/>
                <input type="hidden" name="lng" id="lng" value="${(annonce) ? annonce.lng : ""}"/>

            </div>
        </div>

    </div>
</div>



<!--USER - MODAL-->
<div id="modal_user_annonce" class="modal modal-fixed-footer" data-backdrop="static">
    <div class="modal-content" id="modal_content_user">
        <form id="form_user" action="createUser">
            <div id="form_userAnnonceContent">

            </div>
        </form>
    </div>

    <div class="modal-footer">
        <button class="btn waves-effect waves-light red accent-2 left modal-action modal-close btn-small mr-1"
                type="button">Annuler
            <i class="material-icons left">close</i>
        </button>
        <button class="btn waves-effect waves-light green right btn-small" form="form_user"
                type="button" name="action">Enregistrer
            <i class="material-icons left">save</i> <span id="span_btn_submit_form_user"></span>
        </button>
    </div>
</div>
<!--END-MODAL-->
<g:if test="${annonce}">
    <script>

        var image = "";
        if (typeof images_to_send !== 'undefined') {

            images_to_send = []
        } else {


            var images_to_send = [];
        }


        function deleteIllustration(index) {

            if (index > -1) { // only splice array when item is found
                images_to_send.splice(index, 1); // 2nd parameter means remove one item only
            }

            innerImagesToHtml();

        }

        function image_change(event) {
            let files = event.target.files;


            for (let i = 0; i < files.length; i++) {
                getBase64(files[i])
            }


        }

        var getBase64 = (file) => {
            let reader = new FileReader()
            reader.readAsDataURL(file)
            reader.onload = () => {
                image = reader.result
                images_to_send.push(image)
                innerImagesToHtml();
            }
        }

        function innerImagesToHtml() {
            document.getElementById('images_html').innerHTML = ""
            let html = "";
            for (let i = 0; i < images_to_send.length; i++) {
                html += "<div class= 'col' style='margin: 0 10px;padding: 14px;border: 1px solid black;border-radius: 10px;text-align: center;'> <img src='" + images_to_send[i] + " 'style='height: 55px;width: 60px;'> <button type='button' style='position: absolute;top: -7px;border-radius: 39px;border: 0.1px solid;' onclick='deleteIllustration(" + i + ")'>X</button> </div>"
            }

            document.getElementById('images_html').innerHTML = html


        }


        for (let i = 0; i < document.getElementById('images_from_db').children.length; i++) {
            let url = document.getElementById('images_from_db').children[i].textContent
            const toDataURL = url => fetch(url, {mode: 'cors', cache: 'no-cache'})
                .then(response => response.blob())
                .then(blob => new Promise((resolve, reject) => {

                    const reader = new FileReader()
                    reader.onloadend = () => resolve(reader.result)
                    reader.onerror = reject
                    reader.readAsDataURL(blob)

                }))

            toDataURL(url)
                .then(dataUrl => {

                    images_to_send.push(dataUrl);
                })
                .then(() => {
                    innerImagesToHtml();
                })

        }
    </script>
</g:if>
<g:else>
    <script>
        let image = "";
        if (typeof images_to_send !== 'undefined') {

            images_to_send = []
        } else {


            var images_to_send = [];
        }
        let images_html = [];


        function image_change(event) {
            let files = event.target.files;


            $('#images_html').html("");
            for (let i = 0; i < files.length; i++) {
                getBase64(files[i])
            }


        }

        var getBase64 = (file) => {
            let reader = new FileReader()
            reader.readAsDataURL(file)
            reader.onload = () => {
                image = reader.result
                images_to_send.push(image)


                $('#images_html').append("<img src='" + image + "' id='image_display' style='height: 90px; width: 90px; margin: 0 10px;padding: 5px;border: 1px solid black;border-radius: 10px;'>");


            }
        }
    </script>

</g:else>


