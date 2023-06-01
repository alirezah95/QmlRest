pragma Singleton

import QtQuick 2.15

QtObject {
    // Successful
    readonly property int http_200_OK:                              200
    readonly property int http_201_CREATED:                         201
    readonly property int http_202_ACCEPTED:                        202
    readonly property int http_203_NON_AUTHORITATIVE_INFORMATION:   203
    readonly property int http_204_NO_CONTENT:                      204
    readonly property int http_205_RESET_CONTENT:                   205
    readonly property int http_206_PARTIAL_CONTENT:                 206
    readonly property int http_207_MULTI_STATUS:                    207
    readonly property int http_208_ALREADY_REPORTED:                208
    readonly property int http_226_IM_USED:                         226
    // Client Error
    readonly property int http_400_BAD_REQUEST:                     400
    readonly property int http_401_UNAUTHORIZED:                    401
    readonly property int http_402_PAYMENT_REQUIRED:                402
    readonly property int http_403_FORBIDDEN:                       403
    readonly property int http_404_NOT_FOUND:                       404
    readonly property int http_405_METHOD_NOT_ALLOWED:              405
    readonly property int http_406_NOT_ACCEPTABLE:                  406
    readonly property int http_407_PROXY_AUTHENTICATION_REQUIRED:   407
    readonly property int http_408_REQUEST_TIMEOUT:                 408
    readonly property int http_409_CONFLICT:                        409
    readonly property int http_410_GONE:                            410
    readonly property int http_411_LENGTH_REQUIRED:                 411
    readonly property int http_412_PRECONDITION_FAILED:             412
    readonly property int http_413_REQUEST_ENTITY_TOO_LARGE:        413
    readonly property int http_414_REQUEST_URI_TOO_LONG:            414
    readonly property int http_415_UNSUPPORTED_MEDIA_TYPE:          415
    readonly property int http_416_REQUESTED_RANGE_NOT_SATISFIABLE: 416
    readonly property int http_417_EXPECTATION_FAILED:              417
    readonly property int http_422_UNPROCESSABLE_ENTITY:            422
    readonly property int http_423_LOCKED:                          423
    readonly property int http_424_FAILED_DEPENDENCY:               424
    readonly property int http_426_UPGRADE_REQUIRED:                426
    readonly property int http_428_PRECONDITION_REQUIRED:           428
    readonly property int http_429_TOO_MANY_REQUESTS:               429
    readonly property int http_431_REQUEST_HEADER_FIELDS_TOO_LARGE: 431
    readonly property int http_451_UNAVAILABLE_FOR_LEGAL_REASONS:   451
    // Server Error
    readonly property int http_500_INTERNAL_SERVER_ERROR:           500
    readonly property int http_501_NOT_IMPLEMENTED:                 501
    readonly property int http_502_BAD_GATEWAY:                     502
    readonly property int http_503_SERVICE_UNAVAILABLE:             503
    readonly property int http_504_GATEWAY_TIMEOUT:                 504
    readonly property int http_505_HTTP_VERSION_NOT_SUPPORTED:      505
    readonly property int http_506_VARIANT_ALSO_NEGOTIATES:         506
    readonly property int http_507_INSUFFICIENT_STORAGE:            507
    readonly property int http_508_LOOP_DETECTED:                   508
    readonly property int http_509_BANDWIDTH_LIMIT_EXCEEDED:        509
    readonly property int http_510_NOT_EXTENDED:                    510
    readonly property int http_511_NETWORK_AUTHENTICATION_REQUIRED: 511
}
