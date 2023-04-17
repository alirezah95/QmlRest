pragma Singleton

import QtQuick 2.15

import QmlHttpRequest 1.6

QtObject {
    property string baseUrl: "http://127.0.0.1:8000/"
    property string authorizationType: "JWT"

    function request(token, verb, endpoint, body, timeout, cb, customHeaders=undefined)
    {
        var qhr = QmlHttpRequest.newRequest()

        if (typeof(timeout) === "number") {
            qhr.timeout = timeout
        }

        qhr.ontimeout = () => {
            if (cb instanceof Function) {
                cb({
                       "Error": "Service is unavailable"
                   }, 0)
            }
        }

        qhr.onreadystatechange = () => {
            if (qhr.readyState === QmlHttpRequest.Done) {
                if (Math.floor(qhr.status / 100) === 2) {
                    console.debug(`<Succeeded: ${qhr.status}>: ${verb + " ".repeat(6 - verb.length)}  ${baseUrl + endpoint};`)
                } else {
                    var isServerError = qhr.status > Status.http_500_INTERNAL_SERVER_ERROR
                    console.error(`<Failed   : ${qhr.status}>: ${verb + " ".repeat(6 - verb.length)}  ${baseUrl + endpoint}; ${isServerError ? 'Internal Server Error' : qhr.responseText }`)
                }

                if (cb instanceof Function) {
                    if (qhr.responseText !== "") {
                        let response = toJsObject(qhr.responseText)
                        if (response) {
                            cb(response, qhr.status)
                        } else {
                            cb({
                                   "Error": "Undefined error occured"
                               }, qhr.status)
                        }
                    } else {
                        cb({
                               "Error": "Undefined error occured"
                           }, qhr.status)
                    }
                }
            }
        }

        qhr.open(verb, idInternal.baseUrl + endpoint)
        var contentType = customHeaders && customHeaders.hasOwnProperty("Content-Type")
                ? customHeaders["Content-Type"] : "application/json"
        qhr.setRequestHeader("Content-Type", contentType)
        qhr.setRequestHeader("Accept", "application/json")
        if (token) {
            qhr.setRequestHeader("Authorization", `${JWT} ${token}`)
        }

        var bd = body ? (contentType !== "multipart/form-data"
                         ? JSON.stringify(body) : body) : ""
        qhr.send(bd)
        return qhr
    }

    function toJsObject(str) {
        try {
            str = str.replace(/,?("[\w_-]*"\s?\:\s*null\s*)/g, function () {
                return ""
            })
            var result = JSON.parse(str)
            return result
        } catch (e) {
            return undefined
        }
    }


    //-- get
    function get(endpoint, token_access, callBack, timeout = 40000, customHeaders=undefined)
    {
        return request(token_access, "GET", endpoint, undefined, timeout, callBack, customHeaders)
    }

    //-- add
    function post(endpoint, token_access, body, callBack, timeout = 40000, customHeaders=undefined)
    {
        return request(token_access, "POST", endpoint, body, timeout, callBack, customHeaders)
    }

    //-- edit
    function put(endpoint, token_access, body, callBack, timeout = 40000, customHeaders=undefined)
    {
        return request(token_access, "PATCH", endpoint, body, timeout, callBack, customHeaders)
    }

    //-- delete
    function del(endpoint, token_access, callBack, timeout = 40000, customHeaders=undefined)
    {
        return request(token_access, "DELETE", endpoint, undefined, timeout, callBack, customHeaders)
    }
}
