<#import "template.ftl" as layout>
<#import "user-profile-commons.ftl" as userProfileCommons>
<#import "register-commons.ftl" as registerCommons>

<@layout.registrationLayout displayMessage=messagesPerField.exists('global') displayRequiredFields=false; section>
    <#if section = "header">
        <#if messageHeader??>
            ${kcSanitize(msg("${messageHeader}"))?no_esc}
        <#else>
            ${msg("registerTitle")}
        </#if>
    <#elseif section = "form">
        <div class="rvo-layout-column rvo-layout-gap--xl">
            <div class="rvo-form">
                <form id="kc-register-form" action="${url.registrationAction}" method="post">
                    <div class="rvo-layout-column rvo-layout-gap--md">
                        <div class="utrecht-form-fieldset rvo-form-fieldset">
                            <fieldset class="utrecht-form-fieldset__fieldset utrecht-form-fieldset--html-fieldset">
                                <legend class="utrecht-form-fieldset__legend utrecht-form-fieldset__legend--html-legend">
                                    ${msg("")}
                                </legend>

                                <div class="rvo-layout-column rvo-layout-gap--md">
                                    <@userProfileCommons.userProfileFormFields; callback, attribute>
                                        <#if callback = "beforeField">
                                            <div class="rvo-form-field">
                                        </#if>

                                        <#if callback = "afterField">
                                            </div>
                                            <#if passwordRequired?? && (attribute.name == 'username' || (attribute.name == 'email' && realm.registrationEmailAsUsername))>
                                                <div class="rvo-form-field">
                                                    <div class="rvo-form-field__label">
                                                        <label for="password" class="rvo-label">
                                                            ${msg("password")}
                                                            <span class="rvo-required-asterisk" aria-hidden="true">&#42;</span>
                                                        </label>
                                                    </div>
                                                    <input type="password"
                                                           id="password"
                                                           name="password"
                                                           class="utrecht-textbox utrecht-textbox--html-input utrecht-textbox--lg"
                                                           autocomplete="new-password"
                                                           aria-invalid="<#if messagesPerField.existsError('password','password-confirm')>true</#if>"/>
                                                    <#if messagesPerField.existsError('password')>
                                                        <div class="utrecht-form-field-description utrecht-form-field-description--invalid rvo-form-feedback rvo-form-feedback--error">
                                                            <span class="utrecht-icon rvo-icon rvo-icon-foutmelding rvo-icon--md" role="img" aria-label="Error"></span>
                                                            ${kcSanitize(messagesPerField.get('password'))?no_esc}
                                                        </div>
                                                    </#if>
                                                </div>

                                                <div class="rvo-form-field">
                                                    <div class="rvo-form-field__label">
                                                        <label for="password-confirm" class="rvo-label">
                                                            ${msg("passwordConfirm")}
                                                            <span class="rvo-required-asterisk" aria-hidden="true">&#42;</span>
                                                        </label>
                                                    </div>
                                                    <input type="password"
                                                           id="password-confirm"
                                                           name="password-confirm"
                                                           class="utrecht-textbox utrecht-textbox--html-input utrecht-textbox--lg"
                                                           aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"/>
                                                    <#if messagesPerField.existsError('password-confirm')>
                                                        <div class="utrecht-form-field-description utrecht-form-field-description--invalid rvo-form-feedback rvo-form-feedback--error">
                                                            <span class="utrecht-icon rvo-icon rvo-icon-foutmelding rvo-icon--md" role="img" aria-label="Error"></span>
                                                            ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}
                                                        </div>
                                                    </#if>
                                                </div>
                                            </#if>
                                        </#if>
                                    </@userProfileCommons.userProfileFormFields>
                                </div>
                            </fieldset>
                        </div>

                        <@registerCommons.termsAcceptance/>

                        <#if recaptchaRequired??>
                            <div class="rvo-form-field">
                                <div class="rvo-form-field__label">
                                    <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
                                </div>
                            </div>
                        </#if>

                        <p class="utrecht-button-group">
                            <input type="hidden" id="id-hidden-input" name="credentialId"
                                <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                            <input class="utrecht-button utrecht-button--primary-action utrecht-button--rvo-md"
                                   name="login"
                                   id="kc-login"
                                   type="submit"
                                   value="${msg("doRegister")}"/>
                        </p>

                        <div class="rvo-form-footer">
                            <div id="kc-form-options" class="rvo-form-footer-item">
                                <a href="${url.loginUrl}" class="rvo-link rvo-link--with-icon rvo-link--no-underline">
                                    <span class="utrecht-icon rvo-icon rvo-icon-delta-naar-links rvo-icon--sm rvo-icon--hemelblauw rvo-link__icon--before" role="img" aria-label="Back"></span>
                                    ${kcSanitize(msg("backToLogin"))}
                                </a>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <script type="module" src="${url.resourcesPath}/js/passwordVisibility.js"></script>
    </#if>
</@layout.registrationLayout>
