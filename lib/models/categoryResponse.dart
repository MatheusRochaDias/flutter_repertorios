class CategoryResponse {
    CategoryResponse({
        this.id,
        this.name,
    });

    int id;
    String name;

    factory CategoryResponse.fromJson(Map<String, dynamic> json) => CategoryResponse(
        id: json["id"],
        name: json["name"],
    );

 
}
