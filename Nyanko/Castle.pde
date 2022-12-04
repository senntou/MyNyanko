public class Castle extends Thing{
    float cwidth,cheight;
    PImage icon;
    public Castle(float x,float y){
        this.x = x;
        this.y = y;
        this.cwidth = 100;
        this.cheight = 150;
        this.maxHp = 1000;
        this.hp = maxHp;
        this.aliveFlag = true;
    }
    public void update(){
        pushMatrix();
        translate(this.x,this.y);
        image(this.icon,-64,-128);
        popMatrix();

        drawHpBar();
    }
    public void damaged(float d){
        this.hp -= d;
        if(this.hp <= 0) {
            this.aliveFlag = false;
            this.hp = 0;
        }
    }
    public void drawHpBar(){
        pushMatrix();
        translate(this.x,this.y);
        translate(0,-cheight*1.1);
        strokeWeight(1);
        stroke(0);
        fill(255);
        float length = cwidth * (this.hp/this.maxHp);
        rect(-cwidth/2,-cheight*0.05,length,cheight*0.1);
        popMatrix();
    }
    public float getX(){
        return this.x + cwidth/2;
    }
    public float getY(){
        return this.y;
    }
    public void setIcon(PImage icon){
        this.icon = icon;
    }
}
public class CatCastle extends Castle{

    public CatCastle(float x,float y){
        super(x,y);
    }
    public float getX(){
        return this.x - this.cwidth/2;
    }
}