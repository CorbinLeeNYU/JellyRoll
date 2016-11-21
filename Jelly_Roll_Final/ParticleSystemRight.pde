class ParticleSystemRight{
  
  PVector origin; 
  PVector velocity; 
  
  
  ArrayList<ParticleRight> particles; 
  
  ParticleSystemRight(PVector location){
    
    origin = location.get();
    particles = new ArrayList<ParticleRight>(); 
   
  }
  
  void addParticle(){
    
    particles.add(new ParticleRight(origin)); 
    
  }
  
   void run(){
    Iterator<ParticleRight> it = particles.iterator(); 
    while(it.hasNext()){
      ParticleRight p = it.next();
      p.run();
      if(p.isDead()){
        it.remove(); 
      }  
      
    }

  }
  
  
  void applyForce(PVector f){
    
    for(ParticleRight p: particles){
      p.applyForce(f); 
    }
    
  }
  
}
