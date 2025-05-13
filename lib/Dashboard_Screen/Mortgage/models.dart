class PostsModel {
  
  int? id;
  String? name;
  

  PostsModel({ this.id, this.name});

  PostsModel.fromJson(Map<String, dynamic> json) {
    
    id = json['id'];
    name = json['name'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    
    data['id'] = this.id;
    data['name'] = this.name;
    
    return data;
  }
}
  class SeletArea {
    
    int? id;
    String? name;
    

    SeletArea({ this.id, this.name});

    SeletArea.fromJson(Map<String, dynamic> json) {
      
      id = json['id'];
      name = json['name'];
      
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      
      data['id'] = this.id;
      data['name'] = this.name;
      
      return data;
    }
  }