pragma Singleton

import QtQuick

import QmlHttpRequest

QtObject {
    property string tokenType: "JWT"

    function request(verb, endpoint, token, body, callback, timeout, customHeaders=undefined)
    {
        var qhr = QmlHttpRequest.newRequest()

        if (typeof(timeout) === "number") {
            qhr.timeout = timeout
        }

        qhr.ontimeout = () => {
            if (callback instanceof Function) {
                callback({
                       "Error": "Service is unavailable"
                   }, 0)
            }
        }

        qhr.onreadystatechange = () => {
            if (qhr.readyState === QmlHttpRequest.Done) {
                if (Math.floor(qhr.status / 100) === 2) {
                    console.debug(`<Succeeded: ${qhr.status}>: ${verb + " ".repeat(6 - verb.length)}  ${endpoint};`)
                } else {
                    var isServerError = qhr.status > Status.http_500_INTERNAL_SERVER_ERROR
                    console.error(`<Failed   : ${qhr.status}>: ${verb + " ".repeat(6 - verb.length)}  ${endpoint}; ${isServerError ? 'Internal Server Error' : qhr.responseText }`)
                }

                if (callback instanceof Function) {
                    if (qhr.responseText !== "") {
                        let response = toJsObject(qhr.responseText)
                        if (response) {
                            callback(response, qhr.status)
                        } else {
                            callback({
                                   "Error": "Undefined error occured"
                               }, qhr.status)
                        }
                    } else {
                        callback({
                               "Error": "Undefined error occured"
                           }, qhr.status)
                    }
                }
            }
        }

        qhr.open(verb, endpoint)
        var contentType = customHeaders && customHeaders.hasOwnProperty("Content-Type")
                ? customHeaders["Content-Type"] : "application/json"
        qhr.setRequestHeader("Content-Type", contentType)
        qhr.setRequestHeader("Accept", "application/json")
        if (token) {
            qhr.setRequestHeader("Authorization", `${tokenType} ${token}`)
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
    function get(endpoint, token, callback, timeout=40000, customHeaders=undefined)
    {
        return request("GET", endpoint, token, undefined, callback, timeout, customHeaders)
    }

    //-- add
    function post(endpoint, token, body, callback, timeout=40000, customHeaders=undefined)
    {
        return request("POST", endpoint, token, body, callback, timeout, customHeaders)
    }

    //-- edit
    function put(endpoint, token, body, callback, timeout=40000, customHeaders=undefined)
    {
        return request("PATCH", endpoint, token, body, callback, timeout, customHeaders)
    }

    //-- delete
    function del(endpoint, token, body, callback, timeout=40000, customHeaders=undefined)
    {
        return request("DELETE", endpoint, token, body, callback, timeout, customHeaders)
    }
}
