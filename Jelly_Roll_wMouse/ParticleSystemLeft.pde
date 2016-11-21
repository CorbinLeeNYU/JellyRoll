class ParticleSystemLeft{
  
  PVector origin; 
  PVector velocity; 
  
  
  ArrayList<ParticleLeft> particles; 
  
    ParticleSystemLeft(PVector location){   
    origin = location.get();
    particles = new ArrayList<ParticleLeft>(); 
   
  }
  
  void addParticle(){
    
    particles.add(new ParticleLeft(origin)); 
    
  }
  
   void run(){
    Iterator<ParticleLeft> it = particles.iterator(); 
    while(it.hasNext()){
      ParticleLeft p = it.next();
      p.run();
      if(p.isDead()){
        it.remove(); 
      }  
      
    }

  }
  
  
  void applyForce(PVector f){
    
    for(ParticleLeft p: particles){
      p.applyForce(f); 
    }
    
  }
  
}
