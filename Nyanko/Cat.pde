public class NormalCat extends DefaultCat{
    protected float dy;
    private float jump = 50;
    public NormalCat(float x,float y){
        super(x,y);
    }
    protected void attackMotion(){
        dy = -1 * 50 * sin(PI * ((float)attackFrameCount/(float)attackFrame));
    }
    protected void show(){
        stroke(0);
        strokeWeight(1);
        fill(255);
        ellipse(x,y + dy,30,30);
    }
}
public class Recat extends NormalCat{
    public Recat(float x,float y){
        super(x,y);
    }
    protected void show(){
        stroke(0);
        strokeWeight(1);
        fill(255);
        rect(x-15,y + dy - 15,30,30);
    }
}
public class ImageCat extends NormalCat{
    PImage icon;
    float size;
    public ImageCat(float x,float y){
        super(x,y);
        this.icon = loadImage("kurage.png");
        this.setIcon();
        this.size = 64;
    }
    protected void setIcon(){
        this.icon = loadImage("kurage.png");
    }
    protected void show(){
        image(this.icon,this.x-size/2,this.y + this.dy -size/2);
    }
}
public class Bee extends ImageCat{
    public Bee(float x,float y){
        super(x,y);
        setHp(10);
        this.atk = 4;
        this.cost = 25;
    }
    public void setIcon(){
        this.icon = loadImage("bee.png");
    }
}
public class Kurage extends ImageCat{
    public Kurage(float x,float y){
        super(x,y);
        this.size = 64;
        this.setHp(30);
        this.atk = 15;
    }
    protected void setIcon(){
        this.icon = loadImage("kurage.png");
    }
}
public class Konnyaku extends ImageCat{
    public Konnyaku(float x,float y){
        super(x,y);
        this.setHp(50);
        this.atk = 2;
        this.range = 50;
    }
    protected void setIcon(){
        this.icon = loadImage("konnyaku.png");
    }
}
public class Missile extends NormalCat{
    PImage icon;
    float size;
    float bombRange;
    public Missile(float x,float y){
        super(x,y);
        this.icon = loadImage("missile.png");
        this.size = 64;
        this.atk = 10;
        this.agi = 6;
        this.range = 10;
        this.bombRange = 60;
        this.attackFrame = 2;
        this.setHp(6);
    }
    protected void show(){
        image(this.icon,this.x-size/2,this.y + this.dy -size/2);
    }
    //オーバーライド
    protected void move(){
        boolean attackFlag = false;
        boolean moveFlag = true;

        //敵の城が攻撃範囲内かどうかを判定
        if(this.x - range <= dogCastle.getX() && dogCastle.getX() <= this.x){
            moveFlag = false;
            if(attackFrameCount == 0) attackFlag = true;
        }
        //全ての敵について攻撃範囲内にいるかどうか判定
        //また、最前線にいる敵を保存
        for(Charactor d:dogs.values()){
            if(this.x - range <= d.getX() && d.getX() <= this.x){
                moveFlag = false;
                if(attackFrameCount == 0){
                    attackFlag = true;
                    break;
                }
            }
        }

        if(attackFlag)this.attackStart(this.enemy);
        if(moveFlag) this.x -= agi;
    }
    protected void attackMotion(){
        return ;
    }
    protected void attack(){
        /*
        if(this.x - bombRange <= dogCastle.getX() && dogCastle.getX() <= this.x){
            dogCastle.damaged(this.atk);
        }
        */
        for(Charactor d:dogs.values()){
            if(this.x - bombRange <= d.getX() && d.getX() <= this.x){
                d.damaged(this.atk);
            }
        }
        this.damaged(this.maxHp);
    }
}