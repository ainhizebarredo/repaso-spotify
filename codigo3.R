library(plumber)
#* @apiTitle SPOTIFY


#* @param artista -introduce el nombre 
#* @get /canciones

canciones<-function(artista){
  library(spotidy)
  library(dplyr)
  #buscamos a rosalia para coger su id
  artista<-search_artists(
    artista,
    output = c("tidy", "raw", "id"),
    limit = 1,
    offset = 0,
    token = my_token
  )
  artist_ID<-artista[1,2]
  
  #colaboraciones
  colab<-get_artist_related_artists(
    artist_ID,
    output = c("tidy", "raw"),
    limit = 10,
    offset = 0,
    token = my_token
  )
  #solo 3
  artistas_rel<-colab%>%
    arrange(desc(popularity))%>%
    head(3)
  artistas_rel
  
  #buscamos sus albums
  albums1<-get_artist_albums(
    artistas_rel$related_artist_id[1],
    output = c("tidy", "raw"),
    limit = 20,
    offset = 0,
    token = my_token
  )
  
  #seleccionamos el primero que realizo
  primeralbum1<-albums1%>%
    select(album,album_id,release_date)%>%
    arrange(release_date)
  
  albumid1<-primeralbum1[1,2]
  
  #canciones del album
  canciones1<-get_album_tracks(
    albumid1,
    output = c("tidy", "raw"),
    limit = 20,
    offset = 0,
    token = my_token
  )
  
  #seleccionamos la cancion mas larga
  can_larga1<-canciones1%>%
    arrange(desc(duration))
  canlarga1<-can_larga1[1,]
  
  #buscamos sus albums
  albums2<-get_artist_albums(
    artistas_rel$related_artist_id[2],
    output = c("tidy", "raw"),
    limit = 20,
    offset = 0,
    token = my_token
  )
  
  #seleccionamos el primero que realizo
  primeralbum2<-albums2%>%
    select(album,album_id,release_date)%>%
    arrange(release_date)
  
  albumid2<-primeralbum2[1,2]
  
  #canciones del album
  canciones2<-get_album_tracks(
    albumid2,
    output = c("tidy", "raw"),
    limit = 20,
    offset = 0,
    token = my_token
  )
  
  #seleccionamos la cancion mas larga
  can_larga2<-canciones2%>%
    arrange(desc(duration))
  canlarga2<-can_larga2[1,]
  
  #buscamos sus albums
  albums3<-get_artist_albums(
    artistas_rel$related_artist_id[3],
    output = c("tidy", "raw"),
    limit = 20,
    offset = 0,
    token = my_token
  )
  
  #seleccionamos el primero que realizo
  primeralbum3<-albums3%>%
    select(album,album_id,release_date)%>%
    arrange(release_date)
  
  albumid3<-primeralbum3[1,2]
  
  #canciones del album
  canciones3<-get_album_tracks(
    albumid3,
    output = c("tidy", "raw"),
    limit = 20,
    offset = 0,
    token = my_token
  )
  
  #seleccionamos la cancion mas larga
  can_larga3<-canciones3%>%
    arrange(desc(duration))
  canlarga3<-can_larga3[1,]
  
  resultados<-rbind(canlarga1,canlarga2,canlarga3)
  view(resultados)
}
