<#import "template.ftl" as layout>

<@layout.registrationLayout displayInfo=true displayMessage=!messagesPerField.existsError('username'); section>
    <#if section == "header">
        ${msg("emailForgotTitle")}
    <#elseif section == "form">
        <div class="rvo-layout-column rvo-layout-gap--xl">
            <div class="rvo-form">
                <form id="kc-reset-password-form" action="${url.loginAction}" method="post">
                    <div class="rvo-layout-column rvo-layout-gap--md">
                        <div class="utrecht-form-fieldset rvo-form-fieldset">
                            <fieldset class="utrecht-form-fieldset__fieldset utrecht-form-fieldset--html-fieldset">
                            <div class="rvo-layout-column rvo-layout-gap--md">
                                <div class="rvo-form-field">
                                  <div class="rvo-layout-column">
                                    <div class="utrecht-form-field-description">
                                        <#if realm.duplicateEmailsAllowed>
                                            ${msg("emailInstructionUsername")}
                                        <#else>
                                            ${msg("emailInstruction")}
                                        </#if>
                                    </div>
                                  </div>
                                </div>
                                <div class="rvo-form-field">
                                <div class="rvo-layout-column">
                                    <div class="rvo-form-field__label">
                                        <label for="username" class="rvo-label">
                                            <#if !realm.loginWithEmailAllowed>
                                                ${msg("username")}
                                            <#elseif !realm.registrationEmailAsUsername>
                                                ${msg("usernameOrEmail")}
                                            <#else>
                                                ${msg("email")}
                                            </#if>
                                        </label>
                                    </div>
                                    <input
                                        type="text"
                                        id="username"
                                        name="username"
                                        class="utrecht-textbox utrecht-textbox--html-input utrecht-textbox--lg"
                                        autofocus
                                        value="${(auth.attemptedUsername!'')}"
                                        aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"
                                    />
                                    <#if messagesPerField.existsError('username')>
                                        <div class="utrecht-form-field-description utrecht-form-field-description--invalid rvo-form-feedback rvo-form-feedback--error">
                                            <span class="utrecht-icon rvo-icon rvo-icon-foutmelding rvo-icon--md" role="img" aria-label="Error"></span>
                                            ${kcSanitize(messagesPerField.get('username'))?no_esc}
                                        </div>
                                    </#if>
                                </div>
                                </div>
                                </div>
                            </fieldset>
                        </div>

                        <div class="utrecht-button-group">
                            <input
                                class="utrecht-button utrecht-button--primary-action utrecht-button--rvo-md"
                                type="submit"
                                value="${msg("doSubmit")}"
                            />
                        </div>

                        <div class="rvo-form-footer">
                            <div id="kc-form-options-container">
                                <div id="kc-form-options">
                                    <span>
                                        <a
                                            tabindex="8"
                                            class="rvo-link rvo-link--with-icon rvo-link--no-underline"
                                            href="${url.loginUrl}"
                                        >
                                            <span
                                                class="utrecht-icon rvo-icon rvo-icon-delta-naar-links rvo-icon--sm rvo-icon--hemelblauw rvo-link__icon--before"
                                                role="img"
                                                aria-label="${msg("back")}"
                                            ></span>
                                            ${msg("backToLogin")}
                                        </a>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>
