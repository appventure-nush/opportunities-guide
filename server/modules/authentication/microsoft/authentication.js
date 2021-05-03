/* global WIKI */

// ------------------------------------
// Microsoft Account
// ------------------------------------

const WindowsLiveStrategy = require('passport-microsoft').Strategy
const _ = require('lodash')

module.exports = {
  init (passport, conf) {
    passport.use('microsoft',
      new WindowsLiveStrategy({
        authorizationURL: 'https://login.microsoftonline.com/d72a7172-d5f8-4889-9a85-d7424751592a/oauth2/v2.0/authorize',
        tokenURL: 'https://login.microsoftonline.com/d72a7172-d5f8-4889-9a85-d7424751592a/oauth2/v2.0/token',
        clientID: conf.clientId,
        clientSecret: conf.clientSecret,
        callbackURL: conf.callbackURL,
        scope: ['User.Read', 'email', 'openid', 'profile'],
        passReqToCallback: true
      }, async (req, accessToken, refreshToken, profile, cb) => {
        try {
          const user = await WIKI.models.users.processProfile({
            providerKey: req.params.strategy,
            profile: {
              ...profile,
              picture: _.get(profile, 'photos[0].value', '')
            }
          })
          cb(null, user)
        } catch (err) {
          cb(err, null)
        }
      }
      ))
  }
}
