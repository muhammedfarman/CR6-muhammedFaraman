public class Classes {

    private int id;
    private String className;

    public Classes(int id, String className) {
        this.id = id;
        this.className = className;
    }

    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getClassName() {
        return this.className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    @Override
    public String toString() {
        return className;
    }
}
