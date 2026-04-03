"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.UpdateGrammarDto = void 0;
const mapped_types_1 = require("@nestjs/mapped-types");
const create_grammar_dto_1 = require("./create-grammar.dto");
class UpdateGrammarDto extends (0, mapped_types_1.PartialType)((0, mapped_types_1.OmitType)(create_grammar_dto_1.CreateGrammarDto, ['id'])) {
}
exports.UpdateGrammarDto = UpdateGrammarDto;
//# sourceMappingURL=update-grammar.dto.js.map