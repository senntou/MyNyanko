abstract class Thing{
    protected float x,y;
    protected float maxHp;
    protected float hp;
    protected boolean aliveFlag;
    abstract void update();
    abstract void damaged(float d);
    public float getX(){
        return this.x;
    }
    public boolean isAlive(){
        return this.aliveFlag;
    }
}

abstract class Charactor extends Thing{
    protected float atk;
    protected float agi;
    protected float range;
    protected int attackFrameCount;
    protected int attackFrame;
    protected int intervalFrameCount;
    protected int interval;
    protected Thing enemy;
}
abstract class DefaultCharactor extends Charactor{
    public DefaultCharactor(float x,float y){
        this.x = x;
        this.y = y;
        this.hp = 15;
        this.maxHp = hp;
        this.atk = 5;
        this.agi = 1;
        this.range = 60;
        this.attackFrameCount = 0;
        this.attackFrame = 30;
        this.intervalFrameCount = 0;
        this.interval = 90;
        this.aliveFlag = true;
    }
    public void update(){
        this.move();
        this.show();
        this.updateAttacking();
    }
    abstract protected void move();
    protected void show(){
        stroke(0);
        strokeWeight(1);
        fill(255);
        ellipse(x,y,30,30);
    }
    protected void updateAttacking(){
        //attackFrameCount
        //0 -> moving (there's no enemy)
        if(attackFrameCount == 0) return ;
        attackFrameCount++;
        //1~attackFrame -> readying for attacking -> -interval
        if( 1 <= attackFrameCount ) attackMotion();
        if(attackFrameCount == attackFrame){
            this.attack();
            attackFrameCount = -interval;
        }
        //-interval ~ -1 -> can't attack
    }
    protected void attack(){
        this.enemy.damaged(this.atk);
    }
    protected void attackStart(Thing t){
        this.attackFrameCount = 1;
        this.enemy = t;
    }
    protected void attackMotion(){
        return ;
    }
    public void damaged(float d){
        this.hp -= d;
        if(hp <= 0) this.aliveFlag = false;
    }
    protected void setHp(float h){
        this.hp = h;
        this.maxHp = h;
    }
}