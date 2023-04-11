package mbds_grails_22_23

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }



        /*"/admin/users"(view:"/admin/users")*/
        "/"(controller: "ComingSoon", action: "hello")

        /*"/admin/users"(view:"/admin/users")*/
        "/"(controller: "ComingSoon", action: "hello")
        "/lol"(controller: "admin", action: "user")
      //  "/"(view:"/index")

        "500"(view:'/error')
        "404"(view:'/notFound')
        "/ApiController/annonces"(parseRequest:false)
    }
}
