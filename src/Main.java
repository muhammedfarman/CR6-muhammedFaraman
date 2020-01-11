import javafx.application.Application;
import javafx.beans.value.*;
import javafx.collections.*;
import javafx.geometry.*;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.*;
import javafx.scene.text.Text;
import javafx.stage.Stage;

import java.util.List;


public class Main extends Application {

    //basic gui objects
    private ListView<Teacher> teacherListView;
    private ListView<Classes> classListView;
    private ObservableList<Teacher> data;
    private ObservableList<Classes> dataClasses;

    private Text infoTeacherID;
    private Text infoTeacherName;
    private Text infoTeacherSurname;
    private Text infoTeacherEmail;

    private DbConnection dbaccess;

    //launch the application
    public static void main(String [] args) {

        Application.launch(args);
    }

    //establish connection on start of application
    @Override
    public void init() {

        try {
            dbaccess = new DbConnection();
        }
        catch (Exception e) {

            displayException(e);
        }
    }

    //kill connection when closing application
    @Override
    public void stop() {

        try {
            dbaccess.closeDb();
        }
        catch (Exception e) {

            displayException(e);
        }
    }

    @Override
    public void start(Stage primaryStage) {

        primaryStage.setTitle("School Statistics of Teachers");

        //basic layout
        HBox root = new HBox();
        root.setPadding(new Insets(50));
        root.setSpacing(35);
        root.setAlignment(Pos.CENTER);

        VBox teacherList = new VBox();
        VBox teacherInfo = new VBox();
        VBox teacherClasses = new VBox();


        //layout for teacherList
        Label teachers = new Label("Teachers");

        teacherListView = new ListView<>();
        teacherListView.setMaxSize(200, 400);
        teacherListView.getSelectionModel().selectedIndexProperty().addListener(new ListSelectChangeListener());
        data = getTeachers();
        teacherListView.setItems(data);

        teacherList.setSpacing(15);

        teacherList.getChildren().addAll(teachers, teacherListView);


        //layout for teacherInfo
        Label thisTeacher = new Label("This teacher");

        Text teacherID = new Text("ID");
        Text teacherName = new Text("Name");
        Text teacherSurname = new Text("Surname");
        Text teacherEmail = new Text("Email");

        infoTeacherID = new Text();
        infoTeacherName = new Text();
        infoTeacherSurname = new Text();
        infoTeacherEmail = new Text();

        GridPane infos = new GridPane();
        infos.setAlignment(Pos.CENTER);
        infos.setVgap(30);
        infos.setHgap(20);

        infos.add(teacherID, 1, 1);
        infos.add(teacherName, 1, 2);
        infos.add(teacherSurname, 1, 3);
        infos.add(teacherEmail, 1, 4);

        infos.add(infoTeacherID, 2, 1);
        infos.add(infoTeacherName, 2, 2);
        infos.add(infoTeacherSurname, 2, 3);
        infos.add(infoTeacherEmail, 2, 4);

        teacherInfo.setSpacing(15);

        teacherInfo.getChildren().addAll(thisTeacher, infos);


        //layout for teacherClasses
        Label classes = new Label("Teaches this classes");

        classListView = new ListView<>();
        classListView.setMaxSize(200, 400);

        classListView.setMouseTransparent(true);
        classListView.setFocusTraversable(false);

        teacherClasses.setSpacing(15);

        teacherClasses.getChildren().addAll(classes, classListView);

        //add all to root layout
        root.getChildren().addAll(teacherList, teacherInfo, teacherClasses);

        // scene
        Scene scene = new Scene(root, 750, 400);
        primaryStage.setScene(scene);
        primaryStage.show();

        // initial selection in teacherlist
        teacherListView.getSelectionModel().selectFirst();

    }

    //selection listener for teacher list
    private class ListSelectChangeListener implements ChangeListener<Number> {

        @Override
        public void changed(ObservableValue<? extends Number> ov,
                            Number old_val, Number new_val) {

            if ((new_val.intValue() < 0) || (new_val.intValue() >= data.size())) {

                return; // invalid data
            }
            Teacher teacher = data.get(new_val.intValue());

            infoTeacherID.setText(Integer.toString(teacher.getId()));
            infoTeacherName.setText(teacher.getName());
            infoTeacherSurname.setText(teacher.getSurname());
            infoTeacherEmail.setText(teacher.getEmail());

            dataClasses = getClasses(Integer.valueOf(infoTeacherID.getText()));
            classListView.setItems(dataClasses);

        }
    }

    //displays the teachers from the database in the list
    private ObservableList<Teacher> getTeachers() {

        List<Teacher> teacherList = null;

        try {
            teacherList = dbaccess.teacherList();
        }
        catch (Exception e) {

            displayException(e);
        }

        ObservableList<Teacher> dbData = FXCollections.observableList(teacherList);
        return dbData;
    }

    //displays the classes depending on the selected teacher from the database
    private  ObservableList<Classes> getClasses(int i){

        List<Classes> classesList = null;

        try{
            classesList = dbaccess.classList(i);
        }
        catch (Exception e) {

            displayException(e);

        }

        ObservableList<Classes> dbData = FXCollections.observableList(classesList);
        return dbData;
    }

    //displays an exception incase something goes wrong
    private void displayException(Exception e) {

        System.out.println("###### Exception ######");
        e.printStackTrace();
        System.exit(0);
    }
}