# A unit test for biasadj argument
if(require(testthat))
{
  context("Tests for biasadj")

  test_that("tests for biasadj automatically set based on model fit", {
    #lm
    fit <- tslm(USAccDeaths ~ trend, lambda = 0.5, biasadj = TRUE)
    expect_true(all.equal(forecast(fit), forecast(fit, biasadj=TRUE)))
    
    #HoltWintersZZ
    fit <- ses(USAccDeaths, initial="simple", lambda = 0.5, biasadj = TRUE)
    expect_true(all.equal(forecast(fit), forecast(fit, biasadj=TRUE)))
    
    #arfima
    x <- fracdiff::fracdiff.sim( 100, ma=-.4, d=.3)$series
    fit <- arfima(x)
    expect_true(all.equal(forecast(fit), forecast(fit, biasadj=TRUE)))
    
    #arima
    fit1 <- Arima(USAccDeaths, order = c(0,1,1), seasonal = c(0,1,1), lambda = 0.5, biasadj = TRUE)
    fit2 <- auto.arima(USAccDeaths, lambda = 0.5, biasadj = TRUE)
    expect_true(all.equal(forecast(fit1), forecast(fit1, biasadj=TRUE)))
    expect_true(all.equal(forecast(fit2), forecast(fit2, biasadj=TRUE)))
    expect_true(all.equal(forecast(fit1)$mean, forecast(fit2)$mean))
    
    #ets
    fit <- ets(USAccDeaths, lambda = 0.5, biasadj = TRUE)
    expect_true(all.equal(forecast(fit), forecast(fit, biasadj=TRUE)))
    
    #bats
    fit <- bats(USAccDeaths, use.box.cox = TRUE, biasadj = TRUE)
    expect_true(all.equal(forecast(fit), forecast(fit, biasadj=TRUE)))
    
    #tbats
    fit <- tbats(USAccDeaths, use.box.cox = TRUE, biasadj = TRUE)
    expect_true(all.equal(forecast(fit), forecast(fit, biasadj=TRUE)))
  })
}