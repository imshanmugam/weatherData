@istest
global  class weatherInfoManagerMock implements HttpCalloutMock {

global  HTTPResponse respond(HTTPRequest req) {
    system.debug('call from apex');
    Integer code = 200;
    String status = 'OK';
            HttpResponse resp = new HttpResponse();
            resp.setStatusCode(code);
            resp.setStatus(status);
    		resp.setBody('{"City":"Chennai"}');
            return resp;
        }
}