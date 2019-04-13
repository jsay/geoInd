pltSURE <- function(resid, xvar, lab){
    plot(xvar, resid, xlab= lab, main= paste("Surrogate Analysis", lab))
    abline(h= 0, col= "red", lty= 3, lwd= 2)
    lines(smooth.spline(resid ~ xvar), lwd= 3, col= "blue")
}

surlOLR <- function(mod, newd= NULL){
    if (mod$method!= "logistic") stop("Logistic required")
    gg <- as.numeric(mod$zeta)
    if (is.null(newd)){
        g1 <- unname(as.integer(model.response(model.frame(mod))))
        g6 <- mod$lp
    } else {
        g1 <- as.integer(newd[, "AOCc"])
        g6 <- gg[ 1]-qlogis(predict(mod, newdata= newd, type= 'probs')[, 1])
    }
    nn <- length(g1)
    suls <- sapply(g1, switch,
                   "1"= c(-Inf  , gg[ 1]), "2"= c(gg[ 1], gg[ 2]),
                   "3"= c(gg[ 2], gg[ 3]), "4"= c(gg[ 3], gg[ 4]),
                   "5"= c(gg[ 4], Inf   ))
    sls <- data.frame(unlist(t(suls)))
    rtrunc(nn, spec= "logis", a= sls[, 1], b= sls[, 2],
           location= g6, scale= 1)
}

library(sure)
library(truncdist)
surpOLR <- function(mod, newd= NULL){
    if (mod$method!= "probit") stop("Probit required")
    gg <- as.numeric(mod$zeta)
    if (is.null(newd)){
        g1 <- unname(as.integer(model.response(model.frame(mod))))
        g6 <- mod$lp
    } else {
        g1 <- as.integer(newd[, "AOCc"])
        g6 <- gg[ 1]-qnorm(predict(mod, newdata= newd, type= 'probs')[, 1])
    }
    nn <- length(g1)
    suls <- sapply(g1, switch,
                   "1"= c(-Inf  , gg[ 1]), "2"= c(gg[ 1], gg[ 2]),
                   "3"= c(gg[ 2], gg[ 3]), "4"= c(gg[ 3], gg[ 4]),
                   "5"= c(gg[ 4], Inf   ))
    sls <- data.frame(unlist(t(suls)))
    rtrunc(nn, spec= "norm", a= sls[, 1], b= sls[, 2],
           mean= g6, sd= sqrt(1+ var(g6)))
}

surlGAM <- function(mod, newd= NULL){
    gg <- as.numeric(mod$family$getTheta(TRUE))
    if (is.null(newd)){
        g1 <- as.integer(mod$y)
        g6 <- mod$linear.predictors
    } else {
        g1 <- as.integer(newd[, "AOCc"])
        g6 <- predict(mod, newdata= newd)
    }
    nn <- length(g1)
    suls <- sapply(g1, switch,
                   "1"= c(-Inf  , gg[ 1]), "2"= c(gg[ 1], gg[ 2]),
                   "3"= c(gg[ 2], gg[ 3]), "4"= c(gg[ 3], gg[ 4]),
                   "5"= c(gg[ 4], Inf   ))
    sls <- data.frame(unlist(t(suls)))
    rtrunc(nn, spec= "logis", a= sls[, 1], b= sls[, 2], location= g6)
}
suroldGAM <- function(mod, newd= NULL){
    gg <- as.numeric(mod$family$getTheta(TRUE))
    if (is.null(newd)){
        g1 <- as.integer(mod$y)
        g6 <- mod$linear.predictors
    } else {
        g1 <- as.integer(newd[, "AOCavt"])
        g6 <- predict(mod, newdata= newd)
    }
    nn <- length(g1)
    suls <- sapply(g1, switch,
                   "1"= c(-Inf  , gg[ 1]), "2"= c(gg[ 1], gg[ 2]),
                   "3"= c(gg[ 2], Inf   ))
    sls <- data.frame(unlist(t(suls)))
    rtrunc(nn, spec= "logis", a= sls[, 1], b= sls[, 2], location= g6)
}

surpGLM <- function(mod, newd= NULL){
    if (mod$family$link!= "probit") stop("Probit required")
    if (is.null(newd)){
        g1 <- as.integer(mod$y)
        g6 <- mod$linear.predictors
    } else {
        g1 <- as.integer(newd[, "AOCc"])
        g6 <- predict(mod, newdata= newd, type= "link")
    }
    nn <- length(g1)
    ifelse(g1== 0, rtrunc(nn, spec= "norm", a= -Inf, b= 0, mean= g6),
           rtrunc(nn, spec= "norm", a= 0, b=  Inf, mean= g6))
}

jointNoise <- function(latent, DAT= RegRank){
    jN <- 0
    for (i in 1: 5){
        for (j in levels(DAT$LIBCOM)){
            tmp <- latent[DAT$AOCc== i & DAT$LIBCOM== j]
            if (length(tmp)> 0)
                jN <- jN+ var(tmp)* mean(DAT$AOCc== i & DAT$LIBCOM== j)
        }
    }
    c("Joint Noise"= jN)
}
jointNoise2 <- function(latent, vert= "AOCc", horiz= "LIBCOM", dat= RRank){
    jN <- 0
    for (i in levels(factor(dat[, vert]))){
        for (j in levels(factor(dat[, horiz]))){
            tmp <- latent[dat[, vert]== i & dat[, horiz]== j]
            if (length(tmp)> 1)
                jN <- jN+
                    var(tmp)* mean(dat[, vert]== i & dat[, horiz]== j)
        }
    }
    c("Joint Noise"= jN)
}

jointSignal <- function(latent, DAT= RegRank){
    jS <- rep(0, nrow(DAT))
    for (i in 1: 5){
        for (j in levels(DAT$LIBCOM)){
            jS[DAT$AOCc== i & DAT$LIBCOM== j] <-
                mean(latent[DAT$AOCc== i & DAT$LIBCOM== j])
        }
    }
    c("Joint Signal"= var(jS))
}
jointSignal2 <- function(latent, vert="AOCc", horiz="LIBCOM", dat= RRank){
    jS <- rep(0, nrow(dat))
    for (i in levels(factor(dat[, vert]))){
        for (j in levels(factor(dat[, horiz]))){
            ind <- dat[, vert]== i & dat[, horiz]== j 
            jS[ ind] <- mean(latent[ ind])
        }
    }
    c("Joint Signal"= var(jS))
}

rankSignal <- function(latent, DAT= RegRank){
    rS <- var(ifelse(DAT$AOCc== 1, mean(latent[DAT$AOCc== 1]),
              ifelse(DAT$AOCc== 2, mean(latent[DAT$AOCc== 2]),
              ifelse(DAT$AOCc== 3, mean(latent[DAT$AOCc== 3]),
              ifelse(DAT$AOCc== 4, mean(latent[DAT$AOCc== 4]),
                     mean(latent[DAT$AOCc== 5]))))))
    c("Rank Signal"= rS)
}
rankSignal2 <- function(latent, vert= "AOCc", horiz= "LIBCOM", dat= RRank){
    rS <- rep(NA, nrow(dat))
    for (i in levels(factor(dat[, vert]))){
        rS[ dat[, vert]== i] <- mean(latent[dat[, vert]== i])
    }
    c("Rank Signal"= var(rS))
}

rankNoise <- function(latent, DAT= RegRank){
    rN <- var(latent[DAT$AOCc== 1])* mean(DAT$AOCc== 1)+
        var(latent[DAT$AOCc== 2])*   mean(DAT$AOCc== 2)+
        var(latent[DAT$AOCc== 3])*    mean(DAT$AOCc== 3)+
        var(latent[DAT$AOCc== 4])*    mean(DAT$AOCc== 4)+
        var(latent[DAT$AOCc== 5])*    mean(DAT$AOCc== 5)
    c("Rank Noise"= rN)
}
rankNoise2 <- function(latent, vert= "AOCc", dat= RRank){
    rN <- 0
    for (i in levels(factor(dat[, vert]))){
        rN <- rN+ var(latent[dat[, vert]== i])* mean(dat[, vert]== i)
    }
    c("Rank Noise"= rN)
}

rankResid <- function(latent, DAT= RegRank){
    sig <- rep(0, nrow(DAT))
    for (i in 1: 5){
        for (j in levels(DAT$LIBCOM)){
            sig[DAT$AOCc== i & DAT$LIBCOM== j] <-
                mean(latent[DAT$AOCc== i & DAT$LIBCOM== j])
        }
    }
    rR <- (var(sig[DAT$AOCc== 1])* mean(DAT$AOCc== 1)+
           var(sig[DAT$AOCc== 2])* mean(DAT$AOCc== 2)+
           var(sig[DAT$AOCc== 3])* mean(DAT$AOCc== 3)+
           var(sig[DAT$AOCc== 4])* mean(DAT$AOCc== 4)+
           var(sig[DAT$AOCc== 5])* mean(DAT$AOCc== 5))
    c("Rank Residual"= rR)
}
rankResid2 <- function(latent, vert= "AOCc", horiz= "LIBCOM", dat= RRank){
    sig <- rep(0, nrow(dat)) ; rR <- 0
    for (i in levels(factor(dat[, vert]))){
        for (j in levels(factor(dat[, horiz]))){
            ind <- dat[, vert]== i & dat[, horiz]== j 
            sig[ ind] <- mean(latent[ ind])
        }
    }
    for (i in levels(factor(dat[, vert]))){
        rR <- rR+ var(sig[dat[, vert]== i])* mean(dat[, vert]== i)
    }
    c("Rank Residual"= rR)
}

comSignal <- function(latent, DAT= RegRank){
    cS <- rep(0, nrow(DAT))
    for (j in levels(DAT$LIBCOM)){
        cS[ DAT$LIBCOM== j] <- mean(latent[DAT$LIBCOM== j])
    }
    c("Com Signal"= var(cS))
}
comSignal2 <- function(latent, horiz= "LIBCOM", dat= RRank){
    cS <- rep(0, nrow(dat))
    for (j in levels(factor(dat[, "LIBCOM"]))){
        cS[ dat[, "LIBCOM"]== j] <- mean(latent[dat[, "LIBCOM"]== j])
    }
    c("Com Signal"= var(cS))
}

comNoise <- function(latent, DAT= RegRank){
    cN <- 0
    for (j in levels(DAT$LIBCOM)){
        cN <- cN+ (var(latent[DAT$LIBCOM== j])* mean(DAT$LIBCOM== j)) 
    }
    c("Com Noise"= cN)
}
comNoise2 <- function(latent, horiz= "LIBCOM", dat= RRank){
    cN <- 0
    for (j in levels(factor(dat[, horiz]))){
        cN <- cN+ (var(latent[dat[, horiz]== j])* mean(dat[, horiz]== j)) 
    }
    c("Com Noise"= cN)
}

comResid <- function(latent, DAT= RegRank){
    sig <- rep(0, nrow(DAT))
    for (i in 1: 5){
        for (j in levels(DAT$LIBCOM)){
            sig[DAT$AOCc== i & DAT$LIBCOM== j] <-
                mean(latent[DAT$AOCc== i & DAT$LIBCOM== j])
        }
    }
    cR <- 0
    for (j in levels(DAT$LIBCOM)){
        cR <- cR+ var(sig[DAT$LIBCOM== j])* mean(DAT$LIBCOM== j)
    }
    c("Com Residual"= cR)
}
comResid2 <- function(latent, vert= "AOCc", horiz= "LIBCOM", dat= RRank){
    sig <- rep(0, nrow(dat))
    for (i in levels(factor(dat[, vert]))){
        for (j in levels(factor(dat[, horiz]))){
            sig[dat[, vert]== i & dat[, horiz]== j] <-
                mean(latent[dat[, vert]== i & dat[, horiz]== j])
        }
    }
    cR <- 0
    for (j in levels(factor(dat[, horiz]))){
        cR <- cR+ var(sig[dat[, horiz]== j])* mean(dat[, horiz]== j)
    }
    c("Com Residual"= cR)
}
