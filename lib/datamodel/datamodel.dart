class DataModel {
  String id;
  String icon;
  String title;
  DataModel({required this.icon, required this.id, required this.title});
  static List<DataModel> homeData = [
    DataModel(icon: "attendance", id: "1", title: "Mark Attendance"),
    DataModel(icon: "attendance", id: "2", title: "My Attendance"),
    DataModel(icon: "request", id: "3", title: "Request"),
    DataModel(icon: "myleaves", id: "4", title: "My Leaves"),
    DataModel(icon: "report", id: "5", title: "Report"),
    DataModel(icon: "help", id: "6", title: "Help"),
  ];
  static List<DataModel> basicData = [
    DataModel(icon: "attendance", id: "1", title: "Mark Attendance"),
    DataModel(icon: "attendance", id: "2", title: "My Attendance"),
    DataModel(icon: "request", id: "3", title: "Request"),
    DataModel(icon: "myleaves", id: "4", title: "My Leaves"),
    DataModel(icon: "help", id: "6", title: "Help"),
  ];
}
