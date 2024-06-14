// In this class we will write all the principles we are using of REST principles
// and all the Network class will be implementing this abstract class

abstract class BaseApiServices {
  Future<dynamic> getAPIResponse(String url);
  Future<dynamic> postApiResponse(String url, dynamic data);
  Future<dynamic> patchApiResponse(String url, dynamic data);
  Future<dynamic> putApiResponse(String url, dynamic data);
  Future<dynamic> deleteSpecificApiResponse(String url, dynamic data);
  Future<dynamic> deleteApiResponse(String url);
}