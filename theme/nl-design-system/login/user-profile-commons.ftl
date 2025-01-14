<#macro userProfileFormFields>
    <#assign currentGroup="">

    <#list profile.attributes as attribute>
        <#assign group = (attribute.group)!"">
        <#if group != currentGroup>
            <#assign currentGroup=group>
            <#if currentGroup != "">
                <div class="rvo-form-field"
                <#list group.html5DataAnnotations as key, value>
                    data-${key}="${value}"
                </#list>
                >
                    <#assign groupDisplayHeader=group.displayHeader!"">
                    <#if groupDisplayHeader != "">
                        <#assign groupHeaderText=advancedMsg(groupDisplayHeader)!group>
                    <#else>
                        <#assign groupHeaderText=group.name!"">
                    </#if>
                    <div class="rvo-form-field__label">
                        <label id="header-${attribute.group.name}" class="rvo-label">${groupHeaderText}</label>
                    </div>

                    <#assign groupDisplayDescription=group.displayDescription!"">
                    <#if groupDisplayDescription != "">
                        <#assign groupDescriptionText=advancedMsg(groupDisplayDescription)!"">
                        <div class="rvo-form-field__description">
                            <label id="description-${group.name}" class="rvo-label">${groupDescriptionText}</label>
                        </div>
                    </#if>
                </div>
            </#if>
        </#if>

        <#nested "beforeField" attribute>

        <div class="rvo-form-field">
            <div class="rvo-form-field__label">
                <label for="${attribute.name}" class="rvo-label">
                    ${advancedMsg(attribute.displayName!'')}
                    <#if attribute.required>
                        <span class="rvo-required-asterisk" aria-hidden="true">&#42;</span>
                    </#if>
                </label>
            </div>

            <#if attribute.annotations.inputHelperTextBefore??>
                <div class="utrecht-form-field-description" id="form-help-text-before-${attribute.name}" aria-live="polite">
                    ${kcSanitize(advancedMsg(attribute.annotations.inputHelperTextBefore))?no_esc}
                </div>
            </#if>

            <@inputFieldByType attribute=attribute/>

            <#if messagesPerField.existsError('${attribute.name}')>
                <div class="utrecht-form-field-description utrecht-form-field-description--invalid rvo-form-feedback rvo-form-feedback--error">
                    <span class="utrecht-icon rvo-icon rvo-icon-foutmelding rvo-icon--md" role="img" aria-label="Error"></span>
                    ${kcSanitize(messagesPerField.get('${attribute.name}'))?no_esc}
                </div>
            </#if>

            <#if attribute.annotations.inputHelperTextAfter??>
                <div class="utrecht-form-field-description" id="form-help-text-after-${attribute.name}" aria-live="polite">
                    ${kcSanitize(advancedMsg(attribute.annotations.inputHelperTextAfter))?no_esc}
                </div>
            </#if>

            <#if attribute.html5DataAnnotations?keys?seq_contains('kcMultivalued')>
                <button type="button" class="utrecht-button utrecht-button--secondary-action utrecht-button--rvo-md"
                        onclick="this.parentElement.querySelector('[name=\'${attribute.name}\']').value=''">
                    <span class="utrecht-icon rvo-icon rvo-icon-prullenbak rvo-icon--md" role="img" aria-label="Clear"></span>
                </button>
            </#if>
        </div>

        <#nested "afterField" attribute>

    </#list>
</#macro>

<#macro inputFieldByType attribute>
    <#switch attribute.annotations.inputType!''>
        <#case 'textarea'>
            <textarea id="${attribute.name}"
                     name="${attribute.name}"
                     class="utrecht-textbox utrecht-textbox--html-input utrecht-textbox--lg"
                     aria-invalid="<#if messagesPerField.existsError('${attribute.name}')>true</#if>"
                     <#if attribute.readOnly>disabled</#if>
                     <#if attribute.annotations.inputTypeCols??>cols="${attribute.annotations.inputTypeCols}"</#if>
                     <#if attribute.annotations.inputTypeRows??>rows="${attribute.annotations.inputTypeRows}"</#if>
                     <#if attribute.annotations.inputTypeMaxlength??>maxlength="${attribute.annotations.inputTypeMaxlength}"</#if>
            >${(attribute.value!'')}</textarea>
            <#break>
        <#case 'select'>
        <#case 'multiselect'>
            <select id="${attribute.name}"
                    name="${attribute.name}"
                    class="utrecht-select utrecht-select--html-select utrecht-select--lg"
                    aria-invalid="<#if messagesPerField.existsError('${attribute.name}')>true</#if>"
                    <#if attribute.readOnly>disabled</#if>
                    <#if attribute.annotations.inputType=='multiselect'>multiple</#if>
            >
                <option value=""></option>
                <#list attribute.options.options as option>
                    <option value="${option}" <#if attribute.value == option>selected</#if>>${option}</option>
                </#list>
            </select>
            <#break>
        <#default>
            <input type="<@inputTagType attribute=attribute/>"
                   id="${attribute.name}"
                   name="${attribute.name}"
                   value="${(attribute.value!'')}"
                   class="utrecht-textbox utrecht-textbox--html-input utrecht-textbox--lg"
                   aria-invalid="<#if messagesPerField.existsError('${attribute.name}')>true</#if>"
                   <#if attribute.readOnly>disabled</#if>
                   <#if attribute.autocomplete??>autocomplete="${attribute.autocomplete}"</#if>
                   <#if attribute.annotations.inputTypePlaceholder??>placeholder="${advancedMsg(attribute.annotations.inputTypePlaceholder)}"</#if>
                   <#list attribute.html5DataAnnotations as key, value>
                       data-${key}="${value}"
                   </#list>
            />
    </#switch>
</#macro>

<#macro inputTagType attribute>
    <#compress>
        <#if attribute.annotations.inputType??>
            <#if attribute.annotations.inputType?starts_with("html5-")>
                ${attribute.annotations.inputType[6..]}
            <#else>
                ${attribute.annotations.inputType}
            </#if>
        <#else>
            text
        </#if>
    </#compress>
</#macro>
