<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('totp'); section>
    <#if section="header">
        ${msg("doLogIn")}
    <#elseif section="form">
        <form id="kc-otp-login-form" class="${properties.kcFormClass!}" action="${url.loginAction}"
            method="post">
            <div class="rvo-layout-column rvo-layout-gap--md">
              <div class="utrecht-form-fieldset rvo-form-fieldset">
                <fieldset class="utrecht-form-fieldset__fieldset utrecht-form-fieldset--html-fieldset rvo-layout-gap--md">
                  <#if otpLogin.userOtpCredentials?size gt 1>
                    <div role="group" aria-labelledby="fieldId-label" class="utrecht-form-field utrecht-form-field--text rvo-form-field">
                      <label class="rvo-label" id="fieldId-label" for="fieldId">${msg("loginChooseAuthenticator")}</label>

                      <div class="rvo-radio-button__group">
                      <#list otpLogin.userOtpCredentials as otpCredential>
                        <label class="rvo-radio-button" for="kc-otp-credential-${otpCredential?index}" tabindex="${otpCredential?index}">
                              <input id="kc-otp-credential-${otpCredential?index}" class="utrecht-radio-button" type="radio" name="selectedCredentialId" value="${otpCredential.id}" <#if otpCredential.id == otpLogin.selectedCredentialId>checked="checked"</#if>>
                              ${otpCredential.userLabel}
                          </label>
                      </#list>
                      </div>
                    </div>
                  </#if>

                  <div role="group" aria-labelledby="otp-label" class="utrecht-form-field utrecht-form-field--text rvo-form-field">
                    <div class="rvo-form-field__label">
                      <label class="rvo-label" id="otp-label" for="otp">${msg("loginOtpOneTime")}</label>
                          <#if messagesPerField.existsError('totp')>
                            <div class="utrecht-form-field-description utrecht-form-field-description--invalid rvo-form-feedback rvo-form-feedback--error">
                              <span id="input-error-otp-code" class="utrecht-icon rvo-icon rvo-icon-foutmelding rvo-icon--md rvo-status-icon-foutmelding rvo-status-icon-foutmelding" aria-live="polite" role="img" aria-label="Foutmelding"></span>
                              ${kcSanitize(messagesPerField.get('totp'))?no_esc}
                            </div>
                          </#if>
                    </div>
                    <input id="otp" name="otp" autocomplete="off" placeholder="" type="text" class="utrecht-textbox utrecht-textbox--html-input utrecht-textbox--lg"  dir="auto" value="" aria-invalid="<#if messagesPerField.existsError('totp')>true</#if>"/>
                  </div>
                  <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                      <div class="${properties.kcFormOptionsWrapperClass!}">
                      </div>
                  </div>
                </fieldset>
              </div>
              <p class="utrecht-button-group">
                  <input class="utrecht-button utrecht-button--primary-action utrecht-button--rvo-md" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
              </p>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
