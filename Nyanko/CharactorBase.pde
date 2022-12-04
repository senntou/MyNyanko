public class DefaultCat extends DefaultCharactor{
    public int cost;
    public DefaultCat(float x,float y){
        super(x,y);
        this.cost = 50;
    }
    protected void move(){
        boolean attackFlag = false;
        boolean moveFlag = true;
        float maxEnemyX = 0;

        //敵の城が攻撃範囲内かどうかを判定
        if(this.x - range <= dogCastle.getX() && dogCastle.getX() <= this.x){
            enemy = dogCastle;
            maxEnemyX = dogCastle.getX();
            moveFlag = false;
            if(attackFrameCount == 0) attackFlag = true;
        }
        //全ての敵について攻撃範囲内にいるかどうか判定
        //また、最前線にいる敵を保存
        for(Charactor d:dogs.values()){
            if(this.x - range <= d.getX() && d.getX() <= this.x){
                if(maxEnemyX <= d.getX()) {
                    enemy = d;
                    maxEnemyX = d.getX();
                }
                moveFlag = false;
                if(attackFrameCount == 0) attackFlag = true;
            }
        }

        if(attackFlag)this.attackStart(this.enemy);
        if(moveFlag) this.x -= agi;
    }
}
public class DefaultDog extends DefaultCharactor{
    public DefaultDog(float x,float y){
        super(x,y);
    }
    protected void move(){
        boolean attackFlag = false;
        boolean moveFlag = true;
        float minEnemyX = width;

        //敵の城が攻撃範囲内かどうかを判定
        if(this.x <= catCastle.getX() && catCastle.getX() <= this.x + range){
            enemy = catCastle;
            minEnemyX = catCastle.getX();
            moveFlag = false;
            if(attackFrameCount == 0) attackFlag = true;
        }
        //全ての敵について攻撃範囲内にいるかどうか判定
        //また、最前線にいる敵を保存
        for(Charactor d:cats.values()){
            if(this.x <= d.getX() && d.getX() <= this.x + range){
                if(minEnemyX >= d.getX()) {
                    enemy = d;
                    minEnemyX = d.getX();
                }
                moveFlag = false;
                if(attackFrameCount == 0) attackFlag = true;
            }
        }

        if(attackFlag)this.attackStart(this.enemy);
        if(moveFlag) this.x += agi;
    }
}