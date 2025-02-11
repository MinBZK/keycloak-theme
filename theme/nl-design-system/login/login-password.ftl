<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('password'); section>
    <#if section = "header">
        ${msg("doLogIn")}
    <#elseif section = "form">
        <hr class="rvo-hr"/>
        <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}"
              method="post">
            <div class="utrecht-form-fieldset rvo-form-fieldset">
                <fieldset class="utrecht-form-fieldset__fieldset utrecht-form-fieldset--html-fieldset">
                    <div
                        role="group"
                        aria-labelledby="fieldA-label"
                        class="utrecht-form-field utrecht-form-field--text rvo-form-field"
                    >
                        <div class="rvo-form-field__label">
                            <label for="password" class="rvo-label" id="password-label" for="password">${msg("password")}</label>
                            <#if messagesPerField.existsError('password')>
                                <span id="input-error-password" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                    ${kcSanitize(messagesPerField.get('password'))?no_esc}
                                </span>
                            </#if>
                        </div>
                        <div class="rvo-layout-row rvo-layout-gap--0">
                            <input tabindex="2" id="password" class="${properties.kcInputClass!} utrecht-textbox utrecht-textbox--html-input utrecht-textbox--lg" name="password"
                                   type="password" autocomplete="on" autofocus dir="auto"
                                   aria-invalid="<#if messagesPerField.existsError('password')>true</#if>"
                            />
                            <button class="${properties.kcFormPasswordVisibilityButtonClass!}" type="button" aria-label="${msg('showPassword')}"
                                    aria-controls="password"  data-password-toggle
                                    data-icon-show="${properties.kcFormPasswordVisibilityIconShow!}" data-icon-hide="${properties.kcFormPasswordVisibilityIconHide!}"
                                    data-label-show="${msg('showPassword')}" data-label-hide="${msg('hidePassword')}">
                                <i class="${properties.kcFormPasswordVisibilityIconShow!}" aria-hidden="true"></i>
                            </button>
                        </div>
                    </div>

                    <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                        <div id="kc-form-options">
                        </div>
                        <div class="${properties.kcFormOptionsWrapperClass!}">
                            <#if realm.resetPasswordAllowed>
                                <span><a tabindex="5"
                                         href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></span>
                            </#if>
                        </div>
                    </div>
                </fieldset>
            </div>
            <br/>
            <p class="utrecht-button-group">
                <input tabindex="4" class="utrecht-button utrecht-button--primary-action utrecht-button--rvo-md" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
            </p>
        </form>

        <script type="module" src="${url.resourcesPath}/js/passwordVisibility.js"></script>
    </#if>

</@layout.registrationLayout>
