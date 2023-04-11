package com.mbds.grails

class RedirectController {

    def index() {

        def role = principal.authorities*.authority
        System.out.println()
        if (loggedIn) {
            if ( role.contains("ROLE_ADMIN")){  redirect(controller: "admin", action: "users"  )}
            else if ( role.contains("ROLE_CLIENT")){  redirect(controller: "acceuil", action: "index"  )}
        }
        else{

            redirect(controller: "acceuil", action: "index")
        }

    }
}
