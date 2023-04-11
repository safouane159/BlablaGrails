<h4>${(user) ? "Modification utilisateur" : "Création utilisateur"}</h4>
<input type="hidden" name="id" id="user_id" value="${(user) ? user.id : 0}"/>

${(user) ? role : ""}
<div class="row">
    <div class="col s12">
        <div class="row">
            <div class="input-field col s12">
                <input id="username" name="username" type="text" class="validate"
                       value="${(user) ? user.username : ""}">
                <label for="username" class="${(user) ? "active" : ""}">Username</label>
            </div>
        </div>

        <div class="row">
            <div class="input-field col s6">
                <input id="nomComplet" name="nomComplet" type="text" class="validate"
                       value="${(user) ? user.nomComplet : ""}">
                <label for="nomComplet" class="${(user) ? "active" : ""}">Nom Complet</label>
            </div>

            <div class="input-field col s6">
                <input id="tel" name="tel" type="text" class="validate"
                       value="${(user) ? user.tel : ""}">
                <label for="tel" class="${(user) ? "active" : ""}">Numéro de telephone</label>
            </div>
        </div>

        <div class="row">
            <div class="input-field col s12">
                <input id="mail" name="mail" type="email" class="validate"
                       value="${(user) ? user.mail : ""}">
                <label for="mail" class="${(user) ? "active" : ""}">Email</label>
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
                       value="${(user) ? user.aboutme : ""}">
                <label for="aboutme" class="${(user) ? "active" : ""}">About me</label>
            </div>
        </div>


        <div class="row">
            <div class="input-field col s6">
                <div>
                    <label>Status</label>
                </div>

                <div class="switch">
                    <label>
                        Désactivé
                        <input type="checkbox" name="enabled"
                               id="enabled" ${(user) ? (user.enabled) ? "checked" : "" : "checked"}>
                        <span class="lever"></span>
                        Activé
                    </label>
                </div>
            </div>

            <div class="input-field col s6">
                <div>
                    <label>Role</label>
                </div>

                <div class="input-field">
                    <select name="role" id="role" class="select2 browser-default">
                        <option value="admin" ${(user_is_admin) ? "selected" : ""} >ADMIN</option>
                        <option value="client" ${(!user_is_admin) ? "selected" : ""}>CLIENT</option>
                    </select>
                </div>

            </div>
        </div>

    </div>
</div>