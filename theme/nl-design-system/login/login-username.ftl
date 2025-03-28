<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username') displayInfo=(realm.password && realm.registrationAllowed && !registrationDisabled??); section>
    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section == "socialProviders">
        <#if realm.password && social?? && social.providers?has_content>
            <div id="kc-social-providers" class="rvo-layout-column rvo-layout-align-items-center rvo-layout-gap--md">
                <#list social.providers as provider>
                    <a id="social-${provider.alias}"
                       class="utrecht-button <#if provider?index == 0>utrecht-button--primary-action<#else>utrecht-button--secondary-action</#if> utrecht-button--rvo-full-width rvo-button-group__align-right utrecht-button--rvo-md rvo-link--no-underline"
                       type="button" href="${provider.loginUrl}">
                        <#if provider.iconClasses?has_content>
                            <span
                                class="utrecht-icon rvo-margin-inline-end--2xs rvo-icon rvo-icon--md rvo-icon--hemelblauw ${properties.kcCommonLogoIdP!} ${provider.iconClasses!}"
                                role="img"></span>
                            <span
                                class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${provider.displayName!}</span>
                        <#else>
                            <span
                                class="${properties.kcFormSocialAccountNameClass!}">${provider.displayName!}</span>
                        </#if>
                    </a>
                </#list>
            </div>
        </#if>
    </#if>

</@layout.registrationLayout>
