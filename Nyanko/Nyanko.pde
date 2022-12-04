import java.util.*;

final float WIDTH = 1200;
final float HEIGHT = 900;

final int MAX_CAT_NUMBER = 50;
final float BUTTON_MARGIN = 80;
final float CAT_SPAWN_X = WIDTH * 0.95;
final float CAT_SPAWN_Y = HEIGHT * 0.6;
final float DOG_SPAWN_X = WIDTH * 0.05;
final float DOG_SPAWN_Y = CAT_SPAWN_Y;
final float ENEMY_GENERATE_RATE = 1;
final float MONEY_SPEED = 0.3;

final color lightBlue = color(188,226,232);
final color BG = color(230);

Map<Integer,Charactor> cats = new HashMap<Integer,Charactor>();
Map<Integer,Charactor> dogs = new HashMap<Integer,Charactor>();
Castle dogCastle = new Castle(DOG_SPAWN_X,DOG_SPAWN_Y);
Castle catCastle = new CatCastle(CAT_SPAWN_X,CAT_SPAWN_Y);
ArrayList<CharaButton> buttons = new ArrayList<CharaButton>();

float money = 0;
int maxMoney = 3000;

int key_mouse_count = 0;

void setup(){
    size(1200,900);
    for(int i = 0;i < 5;i++){
        float x = width/2 - BUTTON_MARGIN*2;
        float y = height * 0.9;
        x += i*BUTTON_MARGIN;
        buttons.add(new CharaButton(x,y));
    }
    buttons.get(0).setIcon(loadImage("bee.png"));
    buttons.get(0).setCost(25);
    buttons.get(1).setIcon(loadImage("konnyaku.png"));
    buttons.get(2).setIcon(loadImage("kurage.png"));
    buttons.get(3).setIcon(loadImage("missile.png"));

    catCastle.setIcon(loadImage("CatCastle.png"));
    dogCastle.setIcon(loadImage("sato.png"));

}
void draw(){
    background(BG);
    showGround();
    updateMouseCount();

    //城の描画
    dogCastle.update();
    catCastle.update();
    //キャラ描画
    for(Charactor c : cats.values()){
        c.update();
    }
    for(Charactor d : dogs.values()){
        d.update();
    }
    //死んだキャラの削除
    deleteCharactors();
    //敵の生成
    generateDogs();
    //ボタン描画
    for(CharaButton b:buttons){
        b.show();
    }
    //ボタン検知
    setButton(0,new Bee( CAT_SPAWN_X ,CAT_SPAWN_Y + random(-50,50)));
    setButton(1,new Konnyaku( CAT_SPAWN_X ,CAT_SPAWN_Y + random(-50,50)));
    setButton(2,new Kurage( CAT_SPAWN_X ,CAT_SPAWN_Y + random(-50,50)));
    setButton(3,new Missile( CAT_SPAWN_X ,CAT_SPAWN_Y + random(-50,50)));
    //お金を表示
    showMoney();
    //お金を増やす
    money += MONEY_SPEED;
}
public void showGround(){
    noStroke();
    fill(200,255,200);
    rect(0,height/2,width,height);
}
public boolean addCat(DefaultCat c){
    if(cats.size() > MAX_CAT_NUMBER) return false;
    if(money < c.cost) return false;
    int num = (int)random(0,10000);
    while(cats.containsKey(num)) {
        num = (num + 1) % 10000;
    }

    money -= c.cost;
    cats.put(num,c);

    return true;
}
public void addDog(Charactor c){
    if(dogs.size() > MAX_CAT_NUMBER) return;
    int num = (int)random(0,10000);
    while(dogs.containsKey(num)) {
        num = (num + 1) % 10000;
    }
    dogs.put(num,c);
}
public void deleteCharactors(){
    Set<Integer> deletedCat = new HashSet<Integer>();
    for(int i:cats.keySet()){
        if(!cats.get(i).isAlive()){
            deletedCat.add(i);
        }
    }
    for(int i:deletedCat) cats.remove(i);
    Set<Integer> deletedDog = new HashSet<Integer>();
    for(int i:dogs.keySet()){
        if(!dogs.get(i).isAlive()){
            deletedDog.add(i);
        }
    }
    for(int i:deletedDog) dogs.remove(i);
}
public void generateDogs(){
    if(random(0,100) >= ENEMY_GENERATE_RATE) return;

    addDog( new Takenoko(DOG_SPAWN_X,DOG_SPAWN_Y + random(-50,50) ) );
}
public void setButton(int i,DefaultCat c){
    if(buttons.get(i).pressed()) {
        if(addCat(c)) buttons.get(i).startMeter();
    }
}
public void showMoney(){
    textSize(50);
    fill(0,150,0);
    textAlign(CENTER,CENTER);
    text((int)money,width*0.85,height*0.05);
}
public void updateMouseCount(){
    if(mousePressed && mouseButton == LEFT) key_mouse_count++;
    else key_mouse_count = 0;
}