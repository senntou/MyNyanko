public class CharaButton{
    private float x,y;
    private float bWidth,bHeight;
    private int coolTime;
    private int frameCount;
    private PImage icon;
    private int cost;
    public CharaButton(float x,float y){
        this.x = x;
        this.y = y;
        this.bWidth = 60;
        this.bHeight = 90;
        this.coolTime = 180;
        this.frameCount = 0;
        this.icon = null;
        this.cost = 50;
    }
    public void show(){
        stroke(0);
        strokeWeight(1);
        fill(255);
        rect(x-bWidth/2,y-bHeight/2,bWidth,bHeight);

        this.showMeter();
        this.showIcon();
        this.showCost();
    }
    public void showMeter(){
        if(frameCount == 0) return;

        frameCount = (frameCount + 1) % (int)((float)coolTime * (cost/50.0));
        pushMatrix();
        translate(0,bHeight/2);
        fill(lightBlue);
        float length = bWidth * ((float)frameCount * (50.0/cost) / (float)coolTime);
        rect(x-bWidth/2,y-bHeight/5,length,bHeight/5);
        popMatrix();
    }
    public boolean pressed(){
        if(key_mouse_count != 1) return false;
        if(abs(mouseX - this.x) >= bWidth/2) return false;
        if(abs(mouseY - this.y) >= bHeight/2) return false;
        if(frameCount != 0) return false;

        return true;
    }
    public void setIcon(PImage icon){
        this.icon = icon;
    }
    public void setCost(int cost){
        this.cost = cost;
    }
    protected void showCost(){
        textSize(15);
        textAlign(CENTER,CENTER);
        fill(0);
        text(this.cost,this.x,this.y - 32 - 7);
    }
    protected void showIcon(){
        if(icon == null) return ;

        image(this.icon,this.x-32,this.y -32,64,64);
    }
    public void startMeter(){
        this.frameCount = 1;
    }
}