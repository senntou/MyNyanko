public class NormalDog extends DefaultDog{
    float dy;
    public NormalDog(float x,float y){
        super(x,y);
        dy = 0;
    }
    protected void attackMotion(){
        dy = -1 * 50 * sin(PI * ((float)attackFrameCount/(float)attackFrame));
    }
    protected void show(){
        stroke(0);
        strokeWeight(1);
        fill(50);
        ellipse(x,y + dy,30,30);
    }
}
public class Takenoko extends NormalDog{
    PImage icon;
    float size;
    public Takenoko(float x,float y){
        super(x,y);
        this.icon = loadImage("takenoko.png");
        this.size = 64;
    }
    public void show(){
        image(icon,this.x-size/2,this.y + this.dy-size/2);
    }
}