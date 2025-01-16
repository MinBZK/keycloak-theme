<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section == "header">
        ${msg("loginAccountTitle")}
    <#elseif section == "form">
        <div id="kc-form">
          <div class="rvo-layout-column rvo-layout-gap--md">
            <#if realm.password>
              <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
              <div class="rvo-layout-column rvo-layout-gap--md">
                <div class="utrecht-form-fieldset rvo-form-fieldset">
                  <fieldset class="utrecht-form-fieldset__fieldset utrecht-form-fieldset--html-fieldset">

                    <#if !usernameHidden??>
                      <div role="group" aria-labelledby="username-label" class="utrecht-form-field utrecht-form-field--text rvo-form-field">
                        <div class="rvo-form-field__label">
                          <label class="rvo-label" id="username-label" for="username"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>
                          <#if messagesPerField.existsError('username','password')>
                            <div class="utrecht-form-field-description utrecht-form-field-description--invalid rvo-form-feedback rvo-form-feedback--error">
                              <span id="input-error" class="utrecht-icon rvo-icon rvo-icon-foutmelding rvo-icon--md rvo-status-icon-foutmelding rvo-status-icon-foutmelding" aria-live="polite" role="img" aria-label="Foutmelding"></span>
                              ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                            </div>
                          </#if>
                        </div>
                        <input  tabindex="2" id="username" name="username" placeholder="" type="text" class="utrecht-textbox utrecht-textbox--html-input utrecht-textbox--lg"  autofocus autocomplete="username" dir="auto" value="${(login.username!'')}"  aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"/>
                      </div>
                    </#if>

                    <div role="group" aria-labelledby="password-label" class="utrecht-form-field utrecht-form-field--text rvo-form-field">
                      <div class="rvo-form-field__label">
                        <label class="rvo-label" id="password-label" for="password">${msg("password")}</label>
                        <#if usernameHidden?? && messagesPerField.existsError('username','password')>
                          <div class="utrecht-form-field-description utrecht-form-field-description--invalid rvo-form-feedback rvo-form-feedback--error">
                            <span id="input-error" class="utrecht-icon rvo-icon rvo-icon-foutmelding rvo-icon--md rvo-status-icon-foutmelding rvo-status-icon-foutmelding" aria-live="polite" role="img" aria-label="Foutmelding"></span>
                            ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                          </div>
                        </#if>
                      </div>
                      <input  tabindex="3" id="password" name="password" placeholder="" type="password" autocomplete="current-password" class="utrecht-textbox utrecht-textbox--html-input utrecht-textbox--lg"  aria-label="${msg("showPassword")}" aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"/>
                    </div>
                    <#if realm.resetPasswordAllowed>
                    <div role="group" aria-labelledby="password-label" class="utrecht-form-field utrecht-form-field--text rvo-form-field" style="margin-block-start: -1em;">
                      <div class="rvo-form-field__label">
                        <a class="rvo-link" tabindex="6" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a>
                      </div>
                    </div>
                    </#if>

                    <#if realm.rememberMe && !usernameHidden??>
                      <div class="rvo-checkbox__group">
                        <label class="rvo-checkbox rvo-checkbox--not-checked" for="optionA-cb">
                          <#if login.rememberMe??>
                            <input tabindex="5" class="rvo-checkbox__input" id="rememberMe" name="rememberMe" type="checkbox" checked> ${msg("rememberMe")}
                          <#else>
                            <input tabindex="5" class="rvo-checkbox__input" id="rememberMe" name="rememberMe" type="checkbox"> ${msg("rememberMe")}
                          </#if>
                        </label>
                      </div>
                    </#if>
                  </fieldset>
                </div>

                <p class="utrecht-button-group ">
                    <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                    <input tabindex="7" class="utrecht-button utrecht-button--primary-action utrecht-button--rvo-md" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                </p>
                <div></div>
              </div>
              </form>
            </#if>
          </div>
        </div>
        <script type="module" src="${url.resourcesPath}/js/passwordVisibility.js"></script>
    <#elseif section == "info">
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
        <div
    class="rvo-alert rvo-alert--info rvo-alert--padding-md"
    defaultargs="[object Object]"
  >
    <span
      class="utrecht-icon rvo-icon rvo-icon-info rvo-icon--xl rvo-status-icon-info"
      role="img"
      aria-label="Info"
    ></span>
    <div class="rvo-alert-text">
      <div>
        <div>
         ${msg("noAccount")}
          <a href="${url.registrationUrl}" class="rvo-link rvo-link--logoblauw" tabindex="8">${msg("doRegister")}</a>

        </div>
      </div>
    </div>
  </div>
            </div>
        </#if>
    <#elseif section == "socialProviders">
        <#if realm.password && social?? && social.providers?has_content>
            <div class="rvo-layout-column">
                    <div class="rvo-item-list">
                        <div class="rvo-item-list__item">
                                ${msg("identity-provider-login-label")}
                        </div>
                        <#list social.providers as p>
                            <div class="rvo-item-list__item">
                                <div
                                    class="rvo-layout-row rvo-layout-justify-content-space-between rvo-layout-gap--sm rvo-layout--wrap"
                                >
                                    <a
                                        id="social-${p.alias}"
                                        class="rvo-link"
                                        href="${p.loginUrl}"
                                    >
                                        ${p.displayName!}
                                    </a>
                                </div>
                            </div>
                        </#list>
                    </div>

            </div>
        </#if>
    </#if>
</@layout.registrationLayout>
