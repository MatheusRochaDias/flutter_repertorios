class CitationResponse {
    CitationResponse({
         this.count,
        this.next,
        this.previous,
         this.results,
    });

    int count;
    dynamic next;
    dynamic previous;
    List<Result> results;

    factory CitationResponse.fromJson(Map<String, dynamic> json) => CitationResponse(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

 
}

class Result {
    Result({
         this.id,
         this.text,
         this.author,
         this.category,
    });

    int id;
    String text;
    String author;
    Category category;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        text: json["text"],
        author: json["author"],
        category: Category.fromJson(json["category"]),
    );

    
}

class Category {
    Category({
         this.id,
         this.name,
    });

    int id;
    String name;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
    );

  
}
