enum Status {initial, failed, fetchData}

class States {
   States({
   this.status = Status.initial,
   this.data
  }); 
    Status status;
    String? data;
    States copyWith({
    Status? status,
    String? data
  }) {
    return States(
      status: status ?? this.status,
      data: data ?? this.data
    );
  }
}