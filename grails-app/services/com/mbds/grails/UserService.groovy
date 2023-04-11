package com.mbds.grails

import grails.gorm.services.Service

@Service(User)
interface UserService {

    User get(Serializable id)


    List<User> list(Map args)

    User findByUsername(String username)

    Long count()

    void delete(Serializable id)

    User save(User user)

}