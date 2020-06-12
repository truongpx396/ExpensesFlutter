import 'dart:convert';

import 'package:expenses_mobile/constants/response_status_code.dart';
import 'package:expenses_mobile/model/banner_count_model.dart';
import 'package:expenses_mobile/model/bill_informations/draft_model.dart';
import 'package:expenses_mobile/model/bill_informations/enum.dart';
import 'package:expenses_mobile/model/response_models/banner_count_response.dart';
import 'package:http/http.dart' as http;

String getToken() {
  return 'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ik5VUXhNMFF6UkRrNE56VXpOVGcxUXpGRlJERXdRelEzUlRaQk1FUXpRamd5TVRreVFURXdPUSJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6Ik8yRi1JVFxca25ndXllbmhvdHJ1b25nX2FtYXIiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9naXZlbm5hbWUiOiJLaGFuZyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL3N1cm5hbWUiOiJOR1VZRU4gSE8gVFJVT05HIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZW1haWxhZGRyZXNzIjoia25ndXllbmhvdHJ1b25nQG1hbnR1LmNvbSIsImlzcyI6Imh0dHBzOi8vYXV0aC5tYW50dS5jb20vIiwic3ViIjoiYWR8bzJmaXQtYWR8MTUzOTYxYmMtNmVhZi00ZGNhLTg1OTQtZjQ1OTg2NWY2MzYwIiwiYXVkIjpbImVycGFwaSIsImh0dHBzOi8vbWFudHUuZXUuYXV0aDAuY29tL3VzZXJpbmZvIl0sImlhdCI6MTU5MTk1MzMwMCwiZXhwIjoxNTkxOTk4MzAwLCJhenAiOiJERmRiNmhUTjNLeUVwdlNPSzlVYXI5NmZDUTVmMkZRNiIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUgZW1haWwifQ.LBEQON5-Imld5dIGf8hrCCAnfmJ6O5Op3cq1fR4l38a83ZwNTeMZbzI-stBUG4paysWDrPyjeK2lJePdzSoX4IOvEFq1ahrm77zQ-bsaU7Z9E86dA2TE-nuzv2sxz3QbW1iwcS02bCNpfDQyK26A8irMmgu3i-06wZ3C-pgm1bJHG6urGskT5HTXP3yuHEZ1ljSVOGbdyJv6C3KOBr67XSN5giaUCb5sfV5tMkE6mKvWDvDK6s5xY0-ctSXkXoh7JRhYSyQmqipH9ZGBUXhtgt6WGuDBwr9uQ9E1cLSuYXgVVhTPucQMYWz3qAnZriZT5duAqU4EvhT10VMUpa2eSw';
}

Map<String, dynamic> getHeader() {
  var header = Map<String, String>();
  header['accept'] = 'application/json';
  header['Authorization'] = getToken();
  return header;
}

Future<BannerCountResponseModel> getBannerCount() async {
  var url =
      'https://qaarp.mantu.com/ExpensesMobileV2Api/api/Mobile/GetBannerCount';
  print('Start getting banner count');
  var response = await http.get(url, headers: getHeader());
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    var bannerCount = BannerCountModel.fromResponseJson(jsonResponse);
    return BannerCountResponseModel(
        model: bannerCount, statusCode: response.statusCode);
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return BannerCountResponseModel.fromStatusCode(response.statusCode);
  }
}

Future getBillInformation(
    {int pageIndex, ExpenseStatusEnum status = ExpenseStatusEnum.Draft}) async {
  var url =
      'https://qaarp.mantu.com/ExpensesMobileV2Api/api/Mobile/GetBillInformations?page={page}&refresh={refresh}&status={status}&subcategoryId=-1';
  url = url.replaceFirst('{page}', pageIndex.toString());
  url = url.replaceFirst('{refresh}', 'true');
  url = url.replaceFirst('{status}', ExpenseStatusName[status]);
  print(url);
  var response = await http.get(url, headers: getHeader());
  if (response.statusCode == SUCCESS_CODE) {
    var jsonResponseList = jsonDecode(response.body) as List;
    print(jsonResponseList.toString());
    var draftsList =
        jsonResponseList.map((e) => DraftModel.fromJson(e)).toList();
    print('length: ' + draftsList.length.toString());
    return draftsList;

//    return BannerCountResponseModel(
//        model: bannerCount, statusCode: response.statusCode);
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return BannerCountResponseModel.fromStatusCode(response.statusCode);
  }
}
