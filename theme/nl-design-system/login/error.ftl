<#import "template.ftl" as layout>

<#-- Determine if this is an access denied error -->
<#assign isAccessDenied = false>
<#if message?? && message.summary??>
    <#if message.summary?starts_with("$") && message.summary?ends_with("}")>
        <#assign msgKey = message.summary?substring(2, message.summary?length - 1)>
        <#if msgKey == "accessDeniedNoPermission">
            <#assign isAccessDenied = true>
        </#if>
    <#elseif message.summary == "Access denied">
        <#assign isAccessDenied = true>
    </#if>
</#if>

<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        <#if isAccessDenied>
            ${msg("accessRestrictedTitle")}
        <#else>
            ${msg("errorTitle")}
        </#if>
    <#elseif section = "form">
        <#if isAccessDenied>
            <#-- Friendly access restricted page -->
            <div class="rvo-layout-column rvo-layout-gap--lg">
                <div class="rvo-alert rvo-alert--info rvo-alert--padding-md">
                    <div class="rvo-alert__container">
                        <span
                          class="utrecht-icon rvo-icon rvo-icon-info rvo-icon--xl rvo-status-icon-info"
                          role="img"
                          aria-label="Info"
                        ></span>
                        <div class="rvo-alert-text">
                            <strong>${msg("accessRestrictedHeading")}</strong>
                            <div>${msg("accessRestrictedDescription")}</div>
                        </div>
                    </div>
                </div>

                <div class="rvo-layout-column rvo-layout-gap--sm">
                    <h2 class="utrecht-heading-2">${msg("accessRestrictedHowTo")}</h2>
                    <ol class="rvo-ul rvo-ul--no-margin">
                        <li>${msg("accessRestrictedStep1")}</li>
                        <li>${msg("accessRestrictedStep2")}</li>
                        <li>${msg("accessRestrictedStep3")}</li>
                    </ol>
                </div>

                <#if client?? && client.baseUrl?has_content>
                    <p><a class="rvo-link" href="${client.baseUrl}">${msg("backToApplication")}</a></p>
                </#if>
            </div>
        <#else>
            <#-- Generic error page -->
            <div class="rvo-layout-column rvo-layout-gap--md">
                <div class="rvo-alert rvo-alert--error rvo-alert--padding-md">
                    <div class="rvo-alert__container">
                        <span
                          class="utrecht-icon rvo-icon rvo-icon-foutmelding rvo-icon--xl rvo-status-icon-foutmelding"
                          role="img"
                          aria-label="Foutmelding"
                        ></span>
                        <div class="rvo-alert-text">
                            <div>${kcSanitize(message.summary)?no_esc}</div>
                        </div>
                    </div>
                </div>
                <#if client?? && client.baseUrl?has_content>
                    <p><a class="rvo-link" href="${client.baseUrl}">${msg("backToApplication")}</a></p>
                </#if>
            </div>
        </#if>
    </#if>
</@layout.registrationLayout>
