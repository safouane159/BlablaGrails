<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="backoffice-main"/>
    <title></title>

</head>

<div class="row">
    <div class="col xl3"></div>

    <div class="col s12 m6 l6 xl6">
        <div class="card gradient-shadow blue border-radius-3 animate fadeUp">
            <div class="card-content center">
                <img src="/assets/img_3.png" class="width-40 border-round z-depth-5 responsive-img"
                     alt="images" style="
                height: 140px!important;
                width: 140px!important;
                /* width: 90px; */
                "/>
                <h5 class="white-text lighten-4">Clients</h5>

                <h2 class="white-text lighten-4">+${count_users}</h2>
            </div>
        </div>
    </div>
    <div class="col xl3"></div>
</div>
<div class="row">
    <div class="col xl3"></div>

    <div class="col s12 m6 l6 xl6">
        <div class="card gradient-shadow gradient-45deg-red-pink border-radius-3 animate fadeUp">
            <div class="card-content center">
                <img src="/assets/img.png" class="width-40 border-round z-depth-5 responsive-img"
                     alt="images" style="
                height: 140px!important;
                width: 140px!important;
                /* width: 90px; */
                "/>
                <h5 class="white-text lighten-4">Annonces</h5>

                <h2 class="white-text lighten-4">+${count_annonces}</h2>
            </div>
        </div>
    </div>
    <div class="col xl3"></div>
</div>


</html>