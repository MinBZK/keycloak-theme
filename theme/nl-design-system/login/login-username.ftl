<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username') displayInfo=(realm.password && realm.registrationAllowed && !registrationDisabled??); section>
    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
        <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
            <div class="rvo-form-layout">
                <#if realm.password>
                    <div class="utrecht-form-fieldset rvo-form-fieldset">
                        <fieldset class="utrecht-form-fieldset__fieldset utrecht-form-fieldset--html-fieldset">
                            <#if !usernameHidden??>
                                <div
                                    role="group"
                                    aria-labelledby="fieldId-label"
                                    class="utrecht-form-field utrecht-form-field--text rvo-form-field"
                                >
                                    <div class="rvo-form-field__label">
                                        <label for="username"
                                               id="username-label"
                                               class="rvo-label"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>
                                    </div>

                                    <input tabindex="1" id="username"
                                           aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"
                                           class="utrecht-textbox utrecht-textbox--html-input utrecht-textbox--lg" name="username"
                                           value="${(login.username!'')}"
                                           type="text" autofocus autocomplete="off" dir="auto"/>

                                    <#if messagesPerField.existsError('username')>
                                        <div class="rvo-alert rvo-alert--error rvo-alert--padding-md">
                                            <span
                                                class="utrecht-icon rvo-icon rvo-icon-foutmelding rvo-icon--xl rvo-status-icon-foutmelding"
                                                role="img"
                                                aria-label="Info"
                                            ></span>
                                            <div class="rvo-alert-text">
                                                <span id="input-error-username" aria-live="polite">
                                                    ${kcSanitize(messagesPerField.get('username'))?no_esc}
                                                </span>
                                            </div>
                                        </div>
                                    </#if>
                                </div>
                            </#if>

                            <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                                <div id="kc-form-options">
                                    <#if realm.rememberMe && !usernameHidden??>
                                        <div class="checkbox">
                                            <label>
                                                <#if login.rememberMe??>
                                                    <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"
                                                           checked> ${msg("rememberMe")}
                                                <#else>
                                                    <input tabindex="3" id="rememberMe" name="rememberMe"
                                                           type="checkbox"> ${msg("rememberMe")}
                                                </#if>
                                            </label>
                                        </div>
                                    </#if>
                                </div>
                            </div>
                        </fieldset>
                    </div>

                    <br />

                    <p class="utrecht-button-group">
                        <input tabindex="4"
                               class="utrecht-button utrecht-button--primary-action utrecht-button--rvo-md"
                               name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                    </p>
                </#if>
            </div>
        </form>

    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div id="kc-registration">
                <span>${msg("noAccount")} <a tabindex="6" href="${url.registrationUrl}">${msg("doRegister")}</a></span>
            </div>
        </#if>
    <#elseif section = "socialProviders" >
        <#if realm.password && social?? && social.providers?has_content>
            <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!}">
                <hr/>
                <h4>${msg("identity-provider-login-label")}</h4>

                <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if>">
                    <#list social.providers as p>
                        <a id="social-${p.alias}" class="${properties.kcFormSocialAccountListButtonClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if>"
                                type="button" href="${p.loginUrl}">
                            <#if p.iconClasses?has_content>
                                <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                                <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                            <#else>
                                <span class="${properties.kcFormSocialAccountNameClass!}">${p.displayName!}</span>
                            </#if>
                        </a>
                    </#list>
                </ul>
            </div>
        </#if>
    </#if>

</@layout.registrationLayout>
