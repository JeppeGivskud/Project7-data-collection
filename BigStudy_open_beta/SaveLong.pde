class SaveLong {
  Table newTable;
  Table oldTable;
  ArrayList<Screen> Screens;
  String ID;

  SaveLong(String ID, ArrayList<Screen> Screens) {
    this.ID=ID;
    this.Screens=Screens;
    SaveIndividual();
    AppendOldTable("data/MegaTables/MEGATABLE_LONG.csv");
  }


  void SaveIndividual() {
    this.newTable = new Table();
    String Beer;
    String Attribute;
    int Answer;

    this.newTable.addColumn("ID");
    this.newTable.addColumn("Beer");
    this.newTable.addColumn("Attribute");
    this.newTable.addColumn("Answer");

    Slider Slider;

    println("Beers: "+Screens.size());
    for (int o=0; o<Screens.size(); o++) { //For alle screens
      Beer = Screens.get(o).Name;

      for (int i=0; i < Screens.get(o).SliderGroup.size(); i++) {

        for (int j=0; j<Screens.get(o).SliderGroup.get(i).Sliders.size(); j++) {

          Slider = Screens.get(o).SliderGroup.get(i).Sliders.get(j);

          Attribute = Slider.Question;
          Answer=Slider.Value;

          TableRow row = this.newTable.addRow();
          row.setString("ID", this.ID);
          row.setString("Beer", Beer);
          row.setString("Attribute", Attribute);
          row.setInt("Answer", Answer);
          //println(ID+"ID-"+Beer+"Beer-"+Attribute+"Attribute-"+Answer+"Answer-");
        }
      }
    }
    saveTable(this.newTable, "data/Long/"+this.ID+".csv");
  }


  void AppendOldTable(String Path) {

    this.oldTable = loadTable(Path, "header");
    try {
      saveTable(this.oldTable, Path);
    }
    catch(Exception e) {
      this.oldTable= new Table();
      this.oldTable.addColumn("ID");
      this.oldTable.addColumn("Beer");
      this.oldTable.addColumn("Attribute");
      this.oldTable.addColumn("Answer");
      saveTable(this.oldTable, Path);
    }

    for (TableRow row : this.newTable.rows()) {
      //Load all values from the row
      String Beer = row.getString("Beer");
      String Attribute=row.getString("Attribute");
      int Answer = row.getInt("Answer");

      //Append the original table with new row and values
      TableRow newRow = this.oldTable.addRow();
      newRow.setString("ID", this.ID);
      newRow.setString("Beer", Beer);
      newRow.setString("Attribute", Attribute);
      newRow.setInt("Answer", Answer);
    }
    saveTable(this.oldTable, Path);
  }
}
