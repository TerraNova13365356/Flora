int? level_calc(int data) {
  int num = data;
  if (num == 0) 
  {return 0;}
  else{
    num = (num / 10).floor();
    return num;
  }
  
  
}

String next_date(String curr_date) {
  if (curr_date == '0000-00-00') {
    return 'Not collected';
  } else {
    DateTime date = DateTime.parse(curr_date);
    DateTime next_date = date.add(Duration(days: 30));
    return next_date.toString().substring(0, 10);
  }
}
